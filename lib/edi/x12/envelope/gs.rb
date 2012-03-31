module EDI
  module X12
    module Envelope

      # GS01 (Functional Group Header Code)
      # - Same as the Group Type of the included Transaction Sets.
      #   PO, Purchase Order
      #   SH, Ship Notice
      #   IN, Invoice
      #   FA, Functional Acknowledgement
      #   PC, Purchase Order Change
      #   RA, Remit Advice
      #   RS, Order Status
      #
      # GS02 (Application Sender's Code)
      #
      # GS03 (Application Receiver's Code)
      #
      # GS04 (Date)
      # - YYMMDD, or CCYYMMDD as of 4010.
      #
      # GS05 (Time)
      # - HHMM
      #
      # GS06 (Group Control Number)
      # - Like the ISA control number, is used for audit and to detect
      #   duplicates, missing, or out of sequence groups. Most importantly,
      #   the 997 Functional Acknowledgment, which acts as a return receipt
      #   for the group, references the group control number. May take any
      #   numeric value so long as there are no duplicates in the interchange,
      #   but is usually incremented by one for each group of this type sent
      #   to the same trading partner.
      #
      # GS07 (Responsible Agency Code)
      # - X for X12 or T for TDCC
      #
      # GS08 (Version/Release/Industry Identifier Code)
      # - The first six characters specify the X12 version and release, while
      #   any of the last six may be used to indicate an Industry standard or
      #   Implementation Convention reference.
      #
      class GS < EDI::Envelope
        def initialize(options, root, parent)
          super
          @options[:gs] ||= []
          @options[:gs][0] = "GS"
          @options[:gs][1] ||= ''
          @options[:gs][2] ||= root.options[:sender_id] || ''
          @options[:gs][3] ||= root.options[:receiver_id] || ''
          @options[:gs][4] ||= root.options[:date] || ''
          @options[:gs][5] ||= root.options[:time] || ''
          @options[:gs][6] ||= root.options[:control_number] || '1'
          @options[:gs][7] ||= 'X'
          @options[:gs][8] ||= options[:version] || '00401'
          
          @options[:ge] ||= []
          @options[:ge][0] = "GE"
          @options[:ge][1] = @options[:transaction_count]
          @options[:ge][2] = @options[:gs][6]
        end
        
        def valid?
          # TODO: validate
          true
        end
        
        def header
          @options[:gs].join(root.options[:element_terminator]) + root.options[:segment_terminator]
        end
        
        def trailer
          @options[:ge].join(root.options[:element_terminator]) + root.options[:segment_terminator]
        end
      end
      
    end
  end
end