module EDI
  module X12
    module Segment

      # SE01 (Number of included segments) 
      # - This is used for message integrity, developed before such things as
      #   check sums were widely implemented.
      #
      # SE02 (Transaction Set Control Number)
      # - Must match the Transaction Set Control Number in the ST.
      #
      class SE < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Number of Included Segments', :description => 'Total number of segments included in a transaction set including ST and SE segments.',
            :ref     => 'SE01', :req  => 'M', :type => 'N0', :min  => 1, :max  => 10,
            :value   => @options[:se01] ||= @options[:child_count]
          ))
          add_child(Element.new(
            :name    => 'Transaction Set Control Number', :description => 'Identifying control number that must be unique within the transaction set functional group assigned by the originator for a transaction set.',
            :ref     => 'SE02', :req  => 'M', :type => 'AN', :min  => 4, :max  => 9,
            :value   => @options[:se02] ||= ("%04d" % @options[:control_number])
          ))
        end
        
      end

    end
  end
end