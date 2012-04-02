module EDI
  module X12
    module Loop

      class N1 < EDI::Loop

        def initialize(options = {}, parent = nil)
          super
          add_child(Segment::N1.new(options))
          add_child(Segment::N2.new(options))
          add_child(Segment::N3.new(options))
          add_child(Segment::N4.new(options))
        end
        
      end

    end
  end
end