module EDI
  module X12
    module Segment

      #
      # SCH01 (Quantity)
      # SCH02 (Unit or Basis for Measurement Code)
      # - EA for each
      # SCH05 (Date/Time Qualifier)
      # - 010
      # SCH06 (Date)
      # - CCYYMMDD  
      #
      class SCH < EDI::Segment
        
      end

    end
  end
end