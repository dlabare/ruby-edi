module EDI
  module X12

    class Document < EDI::Document
      
      def initialize(options, root = nil, parent = nil)
        super
        @interchanges = [Interchange.new({}, self, self)]
      end
      
      def print
        @interchanges.map(&:print)
      end
      
    end

  end
end