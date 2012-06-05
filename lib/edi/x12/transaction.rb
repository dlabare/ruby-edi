module EDI
  module X12
    class Transaction < EDI::Transaction

      def control_header
        @control_header || Segment::ST.new(control_options, self)
      end

      def control_trailer
        @control_trailer || Segment::SE.new(control_options, self)
      end
      
      def acknowledgement_loops
        children.select{|c| c.is_a?(Loop::AK2)}
      end

    end
  end
end