module EDI
  module X12

    class Document < EDI::Document
      
      def initialize(options, parent = nil)
        super
        add_child(Interchange.new({}, self))
      end
            
    end

  end
end