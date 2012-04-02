module EDI
  module X12
    module Segment

      # 
      # N401 (City Name)
      # - free form
      # N402 (State or Province Code)
      # - Code (Standard State/Province) as defined by appropriate government
      #   agency
      # N403 (Postal Code)
      # - Code defining international postal zone code excluding punctuation and blanks 
      # N404 (Country Code)
      # - Code identifying the country  
      # 
      class N4 < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'City Name', :description => 'Free form city name.',
            :ref     => 'N401', :req  => 'O', :type => 'AN', :min  => 2, :max  => 30,
            :value   => @options[:n401] ||= @options[:city_name]
          ))
          add_child(Element.new(
            :name    => 'State or Province Code', :description => 'Code (Standard State/Province) as defined by appropriate government agency.',
            :ref     => 'N302', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:n402] ||= @options[:state_code]
          ))
          add_child(Element.new(
            :name    => 'Postal Code', :description => 'Code defining international postal zone code excluding punctuation and blanks.',
            :ref     => 'N303', :req  => 'O', :type => 'ID', :min  => 3, :max  => 15,
            :value   => @options[:n403] ||= @options[:zip_code]
          ))
          add_child(Element.new(
            :name    => 'Country Code', :description => 'Code identifying the country.',
            :ref     => 'N304', :req  => 'O', :type => 'ID', :min  => 2, :max  => 3,
            :value   => @options[:n404] ||= @options[:country_code]
          ))
        end

      end

    end
  end
end