module EDI
  module X12
    module Segment

      # 
      # Carrier Details (Routing Sequence/Transit Time)
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

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Routing Sequence Code', :description => 'Code describing the relationship of a carrier to a specific shipment movement.',
            :ref     => 'TD501', :req  => 'O', :type => 'ID', :min  => 1, :max  => 2,
            :value   => @options[:td501] ||= @options[:routing_sequence_code]
          ))
          add_child(Element.new(
            :name    => 'Identification Code Qualifier', :description => 'Code designating the system/method of code structure used for Identification Code',
            :ref     => 'TD502', :req  => 'O', :type => 'ID', :min  => 1, :max  => 2,
            :value   => @options[:td502] ||= @options[:identification_code_qualifier]
          ))
          add_child(Element.new(
            :name    => 'Identification Code', :description => 'Code identifying a party or other code',
            :ref     => 'TD503', :req  => 'O', :type => 'AN', :min  => 2, :max  => 80,
            :value   => @options[:td503] ||= @options[:identification_code]
          ))
          add_child(Element.new(
            :name    => 'Transportation Method/Type Code', :description => 'Code specifying the method or type of transportation for the shipment',
            :ref     => 'TD504', :req  => 'O', :type => 'ID', :min  => 1, :max  => 2,
            :value   => @options[:td504] ||= @options[:transportation_method_type_code]
          ))
          add_child(Element.new(
            :name    => 'Routing', :description => 'Free-form description of the routing or requested routing for shipment, or the originating carrier\'s identity.',
            :ref     => 'TD05', :req  => 'O', :type => 'DT', :min  => 1, :max  => 35,
            :value   => @options[:td505] ||= @options[:routing]
          ))
        end
        
      end

    end
  end
end