module EDI
  module X12

    class Interchange < EDI::Interchange
            
      def control_header
        Segment::ISA.new(control_options, self)
      end
      
      def control_trailer
        Segment::IEA.new(control_options, self)
      end

    end

  end
end