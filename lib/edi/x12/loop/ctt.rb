module EDI
  module X12
    module Loop

      class CTT < EDI::Loop

        def initialize(options = {}, parent = nil)
          super
          add_child(Segment::CTT.new(options))
        end
        
      end

    end
  end
end