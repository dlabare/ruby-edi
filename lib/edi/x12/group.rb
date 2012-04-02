module EDI
  module X12
    class Group < EDI::Group

      def control_header
        Segment::GS.new(control_options, self)
      end
      
      def control_trailer
        Segment::GE.new(control_options, self)
      end
      
    end
  end
end

