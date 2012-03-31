module EDI
  module X12
    class Transaction < EDI::Transaction

      def print
        envelope = Envelope::ST.new(@options.merge(:type => @options[:type], :segments_count => @segments.length), self.root, self)
        puts envelope.header
        puts envelope.trailer
      end
    
    end
  end
end