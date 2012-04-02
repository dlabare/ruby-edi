module EDI
  module X12
    module Loop

      class PO1 < EDI::Loop

        def initialize(options = {}, parent = nil)
          super
          add_child(Segment::PO1.new(options))
          add_child(Segment::PID.new(options))
          add_child(Segment::SCH.new(options))
        end
        
      end

    end
  end
end