module EDI
  module X12
    module Segment

      class GE < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Number of Transaction Sets Included', :description => 'Total number of transaction sets included in the functional group or interchange (transmission) group terminated by the trailer containing this data element',
            :ref     => 'GE01', :req  => 'M', :type => 'N0', :min  => 1, :max  => 6,
            :value   => @options[:ge01] ||= @options[:child_count]
          ))
          add_child(Element.new(
            :name    => 'Group Control Number', :description => 'Assigned number originated and maintained by the sender.',
            :ref     => 'GE02', :req  => 'M', :type => 'N0', :min  => 1, :max  => 9,
            :value   => @options[:ge02] ||= @options[:control_number]
          ))
        end
        
      end

    end
  end
end