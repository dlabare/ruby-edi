module EDI
  module X12
    module Segment

      #
      # N101 (Name Identifier Code)
      # - BT Bill-to party
      # - ST Ship-to
      # - BS Bill-to and ship-to the same
      # - VN Vendor
      # N102 (Name)
      # - Free-form name
      # N103 (Identification Code Qualifier)
      # - 01 DUNS Number
      # - 15 SAN
      # - 92 Assigned by buyer
      # N104 (Identification Code)
      #
      class N1 < EDI::Segment
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Entity Identifier code', :description => 'Code identifying an organizational entity, a physical location, property or an individual.',
            :ref     => 'N101', :req  => 'M', :type => 'ID', :min  => 2, :max  => 3,
            :value   => @options[:n101] ||= @options[:code]
          ))
          add_child(Element.new(
            :name    => 'Name', :description => 'Free-form name.',
            :ref     => 'N102', :req  => 'C', :type => 'AN', :min  => 1, :max  => 60,
            :value   => @options[:n102] ||= @options[:name]
          ))
          add_child(Element.new(
            :name    => 'Identification Code Qualifier', :description => 'Code designating the system/method of code structure used for identification code.',
            :ref     => 'N103', :req  => 'C', :type => 'ID', :min  => 1, :max  => 2,
            :value   => @options[:n103] ||= @options[:identification_code]
          ))
          add_child(Element.new(
            :name    => 'Identification Code', :description => 'Code identifying a party or other code.',
            :ref     => 'N104', :req  => 'C', :type => 'AN', :min  => 2, :max  => 80,
            :value   => @options[:n104] ||= @options[:identification]
          ))
        end
      end

    end
  end
end