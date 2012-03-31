module EDI
  module X12
    module Envelope
      
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
      # SE01 (Number of included segments) 
      # - This is used for message integrity, developed before such things as
      #   check sums were widely implemented.
      #
      # SE02 (Transaction Set Control Number)
      # - Must match the Transaction Set Control Number in the ST.
      #
      class ST < EDI::Envelope
        
        def initialize(options, root, parent)
          super
          @options[:st]    ||= []
          @options[:st][0] ||= "ST"
          @options[:st][1] ||= @options[:type]
          @options[:st][2] ||= @options[:transaction_count] || '1'

          @options[:se]    ||= []
          @options[:se][0] ||= "SE"
          @options[:se][1] ||= @options[:segment_count]
          @options[:se][2] ||= @options[:st][2]
        end
        
        def valid?
          true # TODO: validate
        end
        
        def header
          @options[:st].join(@root.options[:element_terminator]) + @root.options[:segment_terminator]
        end
        
        def trailer
          @options[:se].join(@root.options[:element_terminator]) + @root.options[:segment_terminator]
        end
        
      end
      
    end
  end
end