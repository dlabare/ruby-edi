module EDI
  module X12
    module Segment

      #
      # CTT01 (Number of line items)
      #
      class CTT < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Number of Line Items', :description => 'Total number of line items in the transaction set.',
            :ref     => 'CTT01', :req  => 'M', :type => 'N0', :min  => 1, :max  => 6,
            :value   => @options[:ctt01] ||= @options[:line_item_count]
          ))
          add_child(Element.new(
            :name    => 'Hash Total', :description => 'Sum of values of the specified data element.',
            :ref     => 'CTT02', :req  => 'O', :type => 'R', :min  => 1, :max  => 10,
            :value   => @options[:CTT02]
          ))
        end
        
      end

    end
  end
end