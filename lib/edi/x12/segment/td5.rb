module EDI
  module X12
    module Segment

      #
      # TD501 (Routing Sequence Code)
      # - B Origin/Delivery Carrier (Any Mode)
      # - O Origin/Delivery Carrier (Air, Motor, or Ocean)
      # TD502 (Identification Code Qualifier)
      # - 01 DUNS Number
      # - 15 SAN
      # TD503 (Identification Code)
      # TD504 (Transportation Method Type Code)
      # TD505 (Routing)
      # - Free-form description of the requested routing or originating carrier’s identity
      #
      class TD5 < EDI::Segment
        
      end

    end
  end
end