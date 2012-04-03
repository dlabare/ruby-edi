module EDI
  module X12

    class PurchaseOrder < Document
      
      attr_accessor :interchange, :group, :transaction
      
      def initialize(options = {}, parent = nil)
        super
        @interchange = @children.first
        @group       = @interchange.add_child(Group.new({:code => 'PO'}))
        @transaction = @group.add_child(Transaction.new({:code => 850}))
        @transaction.add_child(Segment::BEG.new(:po_number => 'F100123456', :po_date => '20120402'))
        @transaction.add_child(Segment::TD5.new(:routing => 'FedEx Ground'))
        @transaction.add_child(Segment::MSG.new(:message => 'Please use our FedEx account 1216-9023-3'))
        @transaction.add_child(Loop::N1.new(:code => 'OB', :name => 'FINDITPARTS', :address1 => '695 S Santa Fe Ave', :city_name => 'Los Angeles', :stata_code => 'CA', :zip_code => 90021, :country_code => 'US'))
        @transaction.add_child(Loop::N1.new(:code => 'VN', :name => 'VELVAC', :address1 => 'Bin No. 53052', :city_name => 'Milwaukee', :state_code => 'WI', :zip_code => '53288-0052', :country_code => 'US'))
        @transaction.add_child(Loop::N1.new(:code => 'ST', :name => 'Constantine Pavlos', :address1 => '2542 Scanlan Place', :city_name => 'Santa Clara', :state_code => 'CA', :zip_code => '95050', :country_code => 'US'))
        @transaction.add_child(Loop::PO1.new(:line_item_number => 1, :quantity => 2, :unit_price => 28.99, :part_number => '715372', :vendor_part_number => '715372', :description => 'Top Hat Add-On Convex Mirrors- Black', :ship_date => Date.today))
        @transaction.add_child(Loop::PO1.new(:line_item_number => 2, :quantity => 1, :unit_price => 12.50, :part_number => '714256', :vendor_part_number => '714256', :description => '2020 Standard Head', :ship_date => Date.today))
        @transaction.add_child(Loop::CTT.new(:line_item_count => 2))
      end
      
    end

  end
end