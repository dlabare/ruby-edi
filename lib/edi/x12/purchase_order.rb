module EDI
  module X12

    class PurchaseOrder < Document
      
      attr_accessor :interchange, :group, :transaction
      
      def initialize(options = {}, parent = nil)
        super
        @interchange = @children.first
        @group       = @interchange.add_child(Group.new({:code => 'PO'}))
        @transaction = @group.add_child(Transaction.new({:code => 850}))
      end
      
    end

  end
end