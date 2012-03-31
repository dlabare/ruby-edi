module EDI
  module X12
    module Segment

      #
      # BEG01 (Transaction Set Purpose Code)
      # - 00 Original
      # BEG02 (Purchase Order Type Code)
      # - NE New Order
      # BEG03 (Purchase Order Number)
      # BEG04 (Release Number)
      # - Optional
      # BEG05 (Date)
      # - Format is CCYYMMDD
      #
      class BEG < EDI::Segment
        
        def initialize(options = {}, root, parent)
          super
          @options[:beg][1] ||= '00'
          @options[:beg][2] ||= 'NE'
          @options[:beg][3] ||= options[:purchse_order_number] || ''
          @options[:beg][4] ||= options[:release_number] || ''
          @options[:beg][5] ||= options[:purchase_order_date] || ''
        end
        
      end

    end
  end
end