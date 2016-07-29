module EDI
  module X12
    class Transaction < EDI::Transaction

      def control_header
        @control_header || Segment::ST.new(control_options, self)
      end

      def control_trailer
        @control_trailer || Segment::SE.new(control_options, self)
      end
      
      # For 997
      def acknowledgement_loops
        children.select{|c| c.is_a?(Loop::AK2)}
      end
      
      # For 856
      def shipment_hierarchical_level_loop
        children.select{|c| c.is_a?(Loop::HL) && c.children.first.HL03 == 'S'}.first
      end
      
      def order_hierarchical_level_loop
        children.select{|c| c.is_a?(Loop::HL) && c.children.first.HL03 == 'O'}.first
      end
      
      def item_hierarchical_level_loops
        children.select{|c| c.is_a?(Loop::HL) && c.children.first.HL03 == 'I'}
      end
      
      def item_hierarchical_level_loop
        item_hierarchical_level_loops.first
      end

    end
  end
end