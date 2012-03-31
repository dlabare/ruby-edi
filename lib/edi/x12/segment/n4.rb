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

        def initialize(options = {})

        end

      end

    end
  end
end