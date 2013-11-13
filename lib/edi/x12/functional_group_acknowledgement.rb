module EDI
  module X12
    class FunctionalGroupAcknowledgement < EDI::Group

      def control_header
        @control_header || Segment::AK1.new(control_options, self)
      end
      
      def control_trailer
        @control_trailer || Segment::AK9.new(control_options, self)
      end
      
    end
  end
end

