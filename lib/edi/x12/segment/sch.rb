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
        
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Quantity', :description => 'Numeric value of quantity.',
            :ref     => 'SCH501', :req  => 'M', :type => 'R', :min  => 1, :max  => 15,
            :value   => @options[:sch501] ||= @options[:quantity]
          ))
          add_child(Element.new(
            :name    => 'Unit or Basis for Measurement Code', :description => 'Code specifying the units in which a value is being expressed, or manner in which a measurement has been taken.',
            :ref     => 'SCH502', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:sch502] ||= @options[:unit_of_measure_code],
            :default => 'EA'
          ))
          add_child(Element.new(
            :name    => 'Routing', :description => 'Free-form description of the routing or requested routing for shipment, or the originating carrier\'s identity.',
            :ref     => 'SCH03', :req  => 'O', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:sch03]
          ))
          add_child(Element.new(
            :name    => 'Routing', :description => 'Free-form description of the routing or requested routing for shipment, or the originating carrier\'s identity.',
            :ref     => 'SCH04', :req  => 'O', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:sch04]
          ))
          add_child(Element.new(
            :name    => 'Date/Time Code', :description => 'Code specifying type of date or time, or both date and time.',
            :ref     => 'SCH05', :req  => 'M', :type => 'ID', :min  => 3, :max  => 3,
            :value   => @options[:sch05] ||= @options[:ship_date_code],
            :default => '010'
          ))
          add_child(Element.new(
            :name    => 'Date', :description => 'Date expressed as CCYYMMDD.',
            :ref     => 'SCH506', :req  => 'M', :type => 'DT', :min  => 8, :max  => 8,
            :value   => @options[:sch06] ||= @options[:ship_date].strftime("%Y%m%d")
          ))
        end
        
      end

    end
  end
end