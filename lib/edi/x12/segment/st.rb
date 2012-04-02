module EDI
  module X12
    module Segment

      # 
      # ST01 (Transaction Set Identifier Code)
      # - A three digit numeric code identifying the Transaction Set type, from
      #   the Transaction Set table.
      # - 850 for Purchase Order
      # - 810 for Invoice
      #
      # ST02 (Transaction Set Control Number)
      # - May take any alphanumeric value so long as there are no duplicates in
      #   the functional group. Usually starts with 0001 in each group, but
      #   there are several other numbering schemes in common usage. Is
      #   referenced in the 997 Functional Acknowledgment if individual
      #   transaction sets are positively acknowledged or if there are errors
      #   in the transaction set indicating a rejection.
      #
      class ST < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Transaction Set Identifier Code', :description => 'Code uniquely identifying a Transaction Set.',
            :ref     => 'ST01', :req  => 'M', :type => 'ID', :min  => 3, :max  => 3,
            :value   => @options[:st01] ||= @options[:code]
          ))
          add_child(Element.new(
            :name    => 'Transaction Set Control Number', :description => 'Identifying control number that must be unique within the transaction set functional group assigned by the originator for a transaction set',
            :ref     => 'ST02', :req  => 'M', :type => 'AN', :min  => 4, :max  => 9,
            :value   => @options[:st02] ||= ("%04d" % @options[:control_number].to_i),
            :default => ''
          ))
        end
        
      end

    end
  end
end