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
        
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Transaction Set Purpose Code', :description => 'Code identifying purpose of transaction set.',
            :ref     => 'BEG01', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:beg01] ||= @options[:purpose_code],
            :default => '00'
          ))
          add_child(Element.new(
            :name    => 'Purchase Order Type Code', :description => 'Code specifying the type of Purchase Order.',
            :ref     => 'BEG02', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:beg02] ||= @options[:type_code],
            :default => 'NE'
          ))
          add_child(Element.new(
            :name    => 'Purchase Order Number', :description => 'Purchase order number.',
            :ref     => 'BEG03', :req  => 'M', :type => 'AN', :min  => 1, :max  => 22,
            :value   => @options[:beg03] ||= @options[:po_number]
          ))
          add_child(Element.new(
            :name    => 'Release Number', :description => 'Optional release number.',
            :ref     => 'BEG04', :req  => 'O', :type => 'AN', :min  => 1, :max  => 7,
            :value   => @options[:beg04] ||= @options[:po_release_number]
          ))
          add_child(Element.new(
            :name    => 'Purchase Order Date', :description => 'The Date of the purchase order - CCYYMMDD.',
            :ref     => 'BEG05', :req  => 'M', :type => 'DT', :min  => 8, :max  => 8,
            :value   => @options[:beg05] ||= @options[:po_date]
          ))
        end
        
      end

    end
  end
end