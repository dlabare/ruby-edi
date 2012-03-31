module EDI
  module X12
    module Segment

      #
      # N101 (Name Identifier Code)
      # - BT Bill-to party
      # - ST Ship-to
      # - BS Bill-to and ship-to the same
      # N102 (Name)
      # - Free-form name
      # N103 (Identification Code Qualifier)
      # - 01 DUNS Number
      # - 15 SAN
      # - 92 Assigned by buyer
      # N104 (Identification Code)
      #
      class N1 < EDI::Segment
        
      end

    end
  end
end