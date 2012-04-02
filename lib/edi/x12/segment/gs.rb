module EDI
  module X12
    module Segment

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
      class GS < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Functional Group Identifier Code', :description => 'Code identifying a group of application related transaction sets.',
            :ref     => 'GS01', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:gs01] ||= @options[:code],
            :default => '00'
          ))
          add_child(Element.new(
            :name    => 'Sender ID', :description => 'Application sender\'s ID.',
            :ref     => 'GS02', :req  => 'M', :type => 'AN', :min  => 2, :max  => 15,
            :value   => @options[:gs02] ||= (@options[:sender_id] || root.options[:sender_id]),
            :default => ''
          ))
          add_child(Element.new(
            :name    => 'Receiver ID', :description => 'Application receiver\'s ID',
            :ref     => 'GS03', :req  => 'M', :type => 'ID', :min  => 2, :max  => 15,
            :value   => @options[:gs03] ||= (@options[:receiver_id] || root.options[:receiver_id])
          ))
          add_child(Element.new(
            :name    => 'Date', :description => 'Expressed as CCYYMMDD',
            :ref     => 'GS04', :req  => 'M', :type => 'DT', :min  => 8, :max  => 8,
            :value   => @options[:gs04] ||= (@options[:date] || root.options[:date]).strftime("%Y%m%d"),
            :default => ''
          ))
          add_child(Element.new(
            :name    => 'Time', :description => 'Expressed as HHMM',
            :ref     => 'GS05', :req  => 'M', :type => 'TM', :min  => 4, :max  => 8,
            :value   => @options[:gs05] ||= (@options[:time] || root.options[:time]).strftime("%H%M")
          ))
          add_child(Element.new(
            :name    => 'Group Control Number', :description => 'Assigned number originated and maintained by the sender',
            :ref     => 'GS06', :req  => 'M', :type => 'N0', :min  => 1, :max  => 9,
            :value   => @options[:gs06] ||= @options[:control_number]
          ))          
          add_child(Element.new(
            :name    => 'Responsible Agency Code', :description => 'Code identifying the issuer of the standard.',
            :ref     => 'GS07', :req  => 'M', :type => 'ID', :min  => 1, :max  => 2,
            :value   => @options[:gs07] ||= @options[:agency_code],
            :default => 'X'
          ))
          add_child(Element.new(
            :name    => 'Version', :description => '',
            :ref     => 'GS08', :req  => 'M', :type => 'AN', :min  => 1, :max  => 12,
            :value   => @options[:gs08] ||= @options[:version],
            :default => '004010'
          ))
        end
        
      end

    end
  end
end