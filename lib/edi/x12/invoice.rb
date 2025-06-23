module EDI
  module X12

    class Invoice < Document
      
      attr_accessor :interchange, :group, :transaction
      
      def initialize(options = {}, parent = nil)
        group_options       = options.delete(:group_options) || {}
        transaction_options = options.delete(:transaction_options) || {}

        super

        @interchange = @children.first
        @group       = @interchange.add_child(Group.new(group_options.merge({:code => 'IN'})))
        @transaction = @group.add_child(Transaction.new(transaction_options.merge({:code => 810})))
      end
      
    end

  end
end

