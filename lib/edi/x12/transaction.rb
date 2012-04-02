module EDI
  module X12
    class Transaction < EDI::Transaction

      def control_header
        Segment::ST.new(control_options, self)
      end

      def control_trailer
        Segment::SE.new(control_options, self)
      end

    end
  end
end