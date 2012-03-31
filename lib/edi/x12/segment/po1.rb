module EDI
  module X12
    module Segment

      #
      # PO101 (Identification)
      # - Sequential line item number
      # PO102 (Quantity Ordered)
      # PO103 (Unit of Measurement Code)
      # - EA Each
      # PO104 (Unit Price)
      # - Unit price can show up to 4-decimals
      # PO105 (Base of Unit Price Code)
      # - PE Price per Each
      # PO106* (Product ID Qualifier)
      # - need more info on codez for this one
      #
      class PO1 < EDI::Segment
        
      end

    end
  end
end