module EDI
  module X12
    class Interchange < EDI::Interchange
      
      def initialize(options, root, parent)
        super

        # X12 version
        @options[:version] ||= '00401'
        
        @groups = []
      end
      
      def add_group(options = {})
        @groups << Group.new(options.merge(:control_number => @groups.size + 1), self.root, self)
      end
      
      def envelope
        Envelope::ISA.new(@options.merge(:group_count => @groups.size), self.root, self)
      end
      
      def valid?
        envelope.valid?
      end
      
      def print
        puts envelope.header
        @groups.map(&:print)
        puts envelope.trailer
      end
      
    end
  end
end