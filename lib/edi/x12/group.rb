module EDI
  module X12
    class Group < EDI::Group

      def add_transaction
        @transactions << Transaction.new(@options.merge(:type => 'PO'), self.root, self)
      end

      def envelope
        Envelope::GS.new(@options.merge(:transaction_count => @transactions.size), self.root, self)
      end
      
      def valid?
        envelope.valid?
      end
      
      def print
        puts envelope.header
        @transactions.map(&:print)
        puts envelope.trailer
      end

    end
  end
end

