module EDI
  module X12

    class Document < EDI::Document
      
      def initialize(options = {}, parent = nil)
        super
        add_child(Interchange.new(options, self))
      end
      
      def transactions_for(blob)
        return blob if blob.is_a?(EDI::Transaction)
        return blob.children.collect {|c| transactions_for(c) }.flatten
      end
      
      def transactions
        return self.transactions_for(self)
      end
      
      def self.zip_segment_options(type, element_array)
        options = {}
        element_array.each_with_index {|val, idx| options["#{type}%02d" % idx.to_s] = val}
        return options
      end

      def self.get_envelope_indexes(segments, segment, element_terminator)
        header_idx  = segments.index(segment)
        trailer_idx = 0

        trailer_id = segment.split(element_terminator).first.gsub(/\w$/, 'E')

        header_idx.upto(segments.size - 1) do |i|
          if segments[i].split(element_terminator).first == trailer_id
            trailer_idx = i
            break
          end
        end

        raise "Could not find the control trailer for segment #{segment}" if trailer_idx == 0

        return header_idx, trailer_idx
      end

      def self.get_loop_indexes(segments, segment, element_terminator)
        start_idx = segments.index(segment)
        end_idx   = segments.size - 1

        loop_id = segment.split(element_terminator).first
        loop_children = EDI::X12.loop_defaults[loop_id]

        start_idx.upto(segments.size - 1) do |i|
          if !loop_children.include?(segments[i].to_s.split(element_terminator).first)
            end_idx = i - 1
            break
          end
        end

        return start_idx, end_idx
      end

      def self.recurse(segments, parent)
        segments.each_with_index do |segment, idx|
          next if segment.nil?
          segment_type = detect_type(segment, parent)
          if segment_type == 'Group'
            h_idx, t_idx          = get_envelope_indexes(segments, segment, parent.element_terminator)
            group                 = Group.new
            group.control_header  = Segment::GS.new(zip_segment_options('GS', segments[h_idx].split(parent.element_terminator)), group)
            group.control_trailer = Segment::GE.new(zip_segment_options('GE', segments[t_idx].split(parent.element_terminator)), group)
            parent.add_child(group)

            inner_segments = segments[(h_idx + 1)..(t_idx - 1)]
            h_idx.upto(t_idx) {|i| segments[i] = nil}

            recurse(inner_segments, group)
          elsif segment_type == 'Transaction'
            h_idx, t_idx        =  get_envelope_indexes(segments, segment, parent.element_terminator)
            txn                 = Transaction.new
            txn.control_header  = Segment::ST.new(zip_segment_options('ST', segments[h_idx].split(parent.element_terminator)), txn)
            txn.control_trailer = Segment::SE.new(zip_segment_options('SE', segments[t_idx].split(parent.element_terminator)), txn)
            parent.add_child(txn)

            inner_segments = segments[(h_idx + 1)..(t_idx - 1)]
            h_idx.upto(t_idx) {|i| segments[i] = nil}

            recurse(inner_segments, txn)
          elsif segment_type == 'Loop'
            # create the loop
            elements = segment.split(parent.element_terminator)
            loop = Loop.const_get(elements.first).new
            parent.add_child(loop)

            # determine the bounds
            s_idx, e_idx = get_loop_indexes(segments, segment, parent.element_terminator)

            inner_segments = segments[s_idx..e_idx]
            s_idx.upto(e_idx) {|i| segments[i] = nil}

            recurse(inner_segments, loop)
          elsif segment_type == 'Segment'
            # add it to the parent, move on
            elements = segment.split(parent.element_terminator)
            seg = Segment.const_get(elements.first).new(zip_segment_options(elements.first, segment.split(parent.element_terminator)))
            segments[segments.index(segment)] = nil
            parent.add_child(seg)
          end
        end
      end

      def self.detect_type(segment, parent)
        s = segment.split(parent.element_terminator).first
        if(s == 'GS')
          return 'Group'
        elsif(s == 'ST')
          return 'Transaction'
        elsif(EDI::X12.loop_defaults.keys.include?(s) && !parent.is_a?(Loop.const_get(s)))
          return 'Loop'
        elsif(EDI::X12.segment_defaults.keys.include?(s))
          return 'Segment'
        end
      end

      def self.parse(file)
        file = File.open(file, 'r') unless file.is_a?(File)
        file_contents = file.read.strip

        segment_terminator = file_contents[105].chr
        element_terminator = file_contents[103].chr

        # build a new document
        document = self.new(:segment_terminator => segment_terminator, :element_terminator => element_terminator)
        
        segments = file_contents.split(segment_terminator)
        segments.map(&:strip!)

        # every document is wrapped in an interchange,
        # so set the interchange envelope to that of the file
        isa = segments.shift
        iea = segments.pop

        isa_options = zip_segment_options('ISA', isa.split(element_terminator))
        iea_options = zip_segment_options('IEA', iea.split(element_terminator))

        interchange = document.interchange
        interchange.control_header  = Segment::ISA.new(isa_options, interchange)
        interchange.control_trailer = Segment::IEA.new(iea_options, interchange)

        # now we're left with the guts of the interchange, here comes the fun stuff
        recurse(segments, interchange)

        return document
      end
    end

  end
end