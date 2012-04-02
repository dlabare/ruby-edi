module EDI
  module X12
    module Segment

      #
      # PO101 (Assigned Identification)
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

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Assigned Identification', :description => 'Alphanumeric characters assigned for differentiation within a transaction set.',
            :ref     => 'PO01', :req  => 'M', :type => 'AN', :min  => 1, :max  => 20,
            :value   => @options[:po01] ||= @options[:line_item_number]
          ))
          add_child(Element.new(
            :name    => 'Quantity Ordered', :description => 'Quantity ordered.',
            :ref     => 'PO02', :req  => 'M', :type => 'R', :min  => 1, :max  => 15,
            :value   => @options[:po02] ||= @options[:quantity]
          ))
          add_child(Element.new(
            :name    => 'Unit of Measurement Code', :description => 'Code specifying the units in which a value is being expressed, or manner in which a measurement has been taken.',
            :ref     => 'PO03', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:po03] ||= @options[:unit_of_measure_code],
            :default => 'EA'
          ))
          add_child(Element.new(
            :name    => 'Unit Price', :description => 'Price per unit.',
            :ref     => 'PO04', :req  => 'M', :type => 'R', :min  => 1, :max  => 17,
            :value   => @options[:po04] ||= @options[:unit_price]
          ))
          add_child(Element.new(
            :name    => 'Basis of Unit Price', :description => 'Code identifying the type of unit price for an item.',
            :ref     => 'PO05', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:po05] ||= @options[:unit_price_code],
            :default => 'PE'
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID Qualifier', :description => 'Code identifying the type/source of the descriptive number used in Product/Service ID.',
            :ref     => 'PO06', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:po06] ||= @options[:part_number_code],
            :default => 'CB'
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID', :description => 'Identifying number for a product or service.',
            :ref     => 'PO07', :req  => 'C', :type => 'AN', :min  => 1, :max  => 48,
            :value   => @options[:po07] ||= @options[:part_number]
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID Qualifier', :description => 'Code identifying the type/source of the descriptive number used in Product/Service ID.',
            :ref     => 'PO08', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:po08] ||= @options[:vendor_part_number_code],
            :default => 'VN'
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID', :description => 'Identifying number for a product or service.',
            :ref     => 'PO09', :req  => 'C', :type => 'AN', :min  => 1, :max  => 48,
            :value   => @options[:po09] ||= @options[:vendor_part_number]
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID Qualifier', :description => 'Code identifying the type/source of the descriptive number used in Product/Service ID.',
            :ref     => 'PO10', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:po10]
          ))
          add_child(Element.new(
            :name    => 'Product/Service ID', :description => 'Identifying number for a product or service.',
            :ref     => 'PO11', :req  => 'C', :type => 'AN', :min  => 1, :max  => 48,
            :value   => @options[:po11]
          ))
        end
        
      end

    end
  end
end