module EDI
  module X12
    module Segment

      # ISA01 (Authorization Information Qualifier)
      # - The default value is 00 - No Authorization Information Present.
      # - This is a required field.
      # - 2 characters
      # - This field is required
      #
      # ISA02 (Authorization Information)
      # - This is an optional field based on the ISA01
      # - 10 characters
      #
      # ISA03 (Security Information Qualifier)
      # - The default value is 00 - No Security Information Present.
      # - This is a required field.
      # - 2 characters
      # - This field is required
      #
      # ISA04 (Security Information)
      # - This was originally used as a kind of a password. The receiver ID might
      #   be public information such as a DUNS number, but this field might contain
      #   a value which is not public information. It is however clear text, so the
      #   security provided is not at a very high level.
      # - This is an optional field based on ISA03
      # - 10 characters
      # 
      # ISA05 (Interchange ID Qualifier)
      # - Use qualifier: 01=Duns or 16=DUNS+4 only
      # - 2 characters
      # - This field is required
      #
      # ISA06 (Interchange Sender ID)
      # - Identifies the sender.
      # - 15 characters
      # - This field is required
      #
      # ISA07 (Interchange ID Qualifier)
      # - Use qualifier: 01=Duns or 16=DUNS+4 only
      # - 2 characters
      # - This field is required
      #
      # ISA08 (Interchange Receiver ID)
      # - Identifies the receiver.
      # - 15 characters
      # - This field is required
      #
      # ISA09 (Interchange Date)
      # - YYMMDD
      # - 6 characters
      #
      # ISA10 (Interchange Time)
      # - HHMM
      # - 4 characters
      # 
      # ISA11 (Interchange Control Standards Identifier)
      # - The default value for the standard identifier is U - U.S. EDI Community
      #   of ASC X12, TDCC and UCS.
      # - 1 character
      #
      # ISA12 (Interchange Control Version Number)
      # - Indicates the version of the ISA/IEA envelope
      # - Default is 00401 - Standards Approved for Publication.
      # - 5 characters
      #
      # ISA13 (Interchange Control Number)
      # - Uniquely identifies an interchange for tracking by trading partners and
      #   VANS, and can be used to detect duplicate, missing, or out of sequence
      #   transmissions. May take any numeric value, but is usually incremented
      #   by one for each interchange sent to the same trading partner.
      # - This is a required field
      # - 9 characters
      #
      # ISA14 (Acknowledgment Requested)
      # - Indicates a request for a TA3 Interchange Acknowledgment to be sent.
      # - This is a required field
      # - 1 character (0 or 1)
      #
      # ISA15 (Test Indicator)
      # - T for Test or P Production
      # - This is a required field
      # - 1 character
      #
      # ISA16 (Subelement Separator)
      # - This is a required field
      # - 1 character
      #
      class ISA < EDI::Segment
        
        VALID_HEADER_LENGTH = 106
        
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Authorization Information Qualifier', :description => 'Code to identify the type of information in the Authorization Information',
            :ref     => 'ISA01', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:isa01] ||= @options[:authorization_information_code],
            :default => '00'
          ))
          add_child(Element.new(
            :name    => 'Authorization Information', :description => 'Information used for additional identification or authorization of the interchange sender or the data in the interchange; the type of information is set by the Authorization Information Qualifier.',
            :ref     => 'ISA02', :req  => 'O', :type => 'AN', :min  => 10, :max  => 10,
            :value   => @options[:isa02] ||= @options[:authorization_information],
            :default => ''.ljust(10)
          ))
          add_child(Element.new(
            :name    => 'Security Information Qualifier', :description => 'Code to identify the type of information in the Security Information.',
            :ref     => 'ISA03', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:isa03] ||= @options[:security_information_code],
            :default => '00'
          ))
          add_child(Element.new(
            :name    => 'Security Information', :description => 'This is used for identifying the security information about the interchange sender or the data in the interchange; the type of information is set by the Security Information Qualifier.',
            :ref     => 'ISA04', :req  => 'M', :type => 'AN', :min  => 10, :max  => 10,
            :value   => @options[:isa04] ||= @options[:security_information],
            :default => ''.ljust(10)
          ))
          add_child(Element.new(
            :name    => 'Interchange ID Qualifier', :description => 'Qualifier to designate the system/method of code structure used to designate the sender ID element being qualified.',
            :ref     => 'ISA05', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:isa05] ||= @options[:sender_id_code],
            :default => '01'
          ))
          add_child(Element.new(
            :name    => 'Interchange Sender ID', :description => 'Identification code published by the sender for other parties to use as the receiver ID to route data to them; the sender always codes this value in the sender ID element',
            :ref     => 'ISA06', :req  => 'M', :type => 'AN', :min  => 15, :max  => 15,
            :value   => @options[:isa06] ||= (@options[:sender_id] || root.options[:sender_id]).ljust(15)
          ))          
          add_child(Element.new(
            :name    => 'Interchange ID Qualifier', :description => 'Qualifier to designate the system/method of code structure used to designate the sender ID element being qualified.',
            :ref     => 'ISA07', :req  => 'M', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:isa07] ||= @options[:receiver_id_code],
            :default => '01'
          ))
          add_child(Element.new(
            :name    => 'Interchange Receiver ID', :description => 'Identification code published by the receiver of the data; When sending, it is used by the sender as their sending ID, thus other parties sending to them will use this as a receiving ID to route data to them.',
            :ref     => 'ISA08', :req  => 'M', :type => 'AN', :min  => 15, :max  => 15,
            :value   => @options[:isa08] ||= (@options[:receiver_id] || root.options[:receiver_id]).ljust(15)
          ))
          add_child(Element.new(
            :name    => 'Interchange Date', :description => 'Date of the interchange',
            :ref     => 'ISA09', :req  => 'M', :type => 'DT', :min  => 6, :max  => 6,
            :value   => @options[:isa09] ||= (@options[:date] || root.options[:date]).strftime("%y%m%d")
          ))
          add_child(Element.new(
            :name    => 'Interchange Time', :description => 'Time of the interchange.',
            :ref     => 'ISA10', :req  => 'M', :type => 'TM', :min  => 4, :max  => 4,
            :value   => @options[:isa10] ||= (@options[:time] || root.options[:time]).strftime("%H%M")
          ))
          add_child(Element.new(
            :name    => 'Interchange Control Standards Identifier', :description => 'Code to identify the agency responsible for the control standard used by the message that is enclosed by the interchange header and trailer.',
            :ref     => 'ISA11', :req  => 'M', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:isa11] ||= @options[:standards_id],
            :default => 'U'
          ))
          add_child(Element.new(
            :name    => 'Interchange Control Version Number', :description => 'Code specifying the version number of the interchange control segments.',
            :ref     => 'ISA12', :req  => 'M', :type => 'ID', :min  => 5, :max  => 5,
            :value   => @options[:isa12] ||= @options[:version],
            :default => '00401'
          ))
          add_child(Element.new(
            :name    => 'Interchange Control Number', :description => 'A control number assigned by the interchange sender.',
            :ref     => 'ISA13', :req  => 'M', :type => 'N0', :min  => 9, :max  => 9,
            :value   => @options[:isa13] ||= ("%09d" % @options[:control_number].to_i)
          ))
          add_child(Element.new(
            :name    => 'Acknowledgment Requested', :description => 'Code sent by the sender to request an interchange acknowledgment.',
            :ref     => 'ISA14', :req  => 'M', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:isa14] ||= @options[:ack_requested],
            :default => '0'
          ))
          add_child(Element.new(
            :name    => 'Usage Indicator', :description => 'Code to indicate whether data enclosed by this interchange envelope is test, production or information.',
            :ref     => 'ISA15', :req  => 'M', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:isa15] ||= @options[:environment],
            :default => 'T'
          ))
          add_child(Element.new(
            :name    => 'Sub-element Separator', :description => 'The character used to separate sub-elements.',
            :ref     => 'ISA16', :req  => 'M', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:isa16] ||= @options[:sub_element_termitator],
            :default => '@'
          ))
        end
        
        # def valid?
        #   super
        # 
        #   # validate field lengths
        #   root.errors << "ISA01 is an invalid length: #{self.isa01.length}" unless self.isa01.length == 2
        #   root.errors << "ISA02 is an invalid length: #{self.isa02.length}" unless self.isa02.length == 10
        #   root.errors << "ISA03 is an invalid length: #{self.isa03.length}" unless self.isa03.length == 2
        #   root.errors << "ISA04 is an invalid length: #{self.isa04.length}" unless self.isa04.length == 10
        #   root.errors << "ISA05 is an invalid length: #{self.isa05.length}" unless self.isa05.length == 2
        #   root.errors << "ISA06 is an invalid length: #{self.isa06.length}" unless self.isa06.length == 15
        #   root.errors << "ISA07 is an invalid length: #{self.isa07.length}" unless self.isa07.length == 2
        #   root.errors << "ISA08 is an invalid length: #{self.isa08.length}" unless self.isa08.length == 15
        #   root.errors << "ISA09 is an invalid length: #{self.isa09.length}" unless self.isa09.length == 6
        #   root.errors << "ISA10 is an invalid length: #{self.isa10.length}" unless self.isa10.length == 4
        #   root.errors << "ISA11 is an invalid length: #{self.isa11.length}" unless self.isa11.length == 1
        #   root.errors << "ISA12 is an invalid length: #{self.isa12.length}" unless self.isa12.length == 5
        #   root.errors << "ISA13 is an invalid length: #{self.isa13.length}" unless self.isa13.length == 9
        #   root.errors << "ISA14 is an invalid length: #{self.isa14.length}" unless self.isa14.length == 1
        #   root.errors << "ISA15 is an invalid length: #{self.isa15.length}" unless self.isa15.length == 1
        #   root.errors << "ISA16 is an invalid length: #{self.isa16.length}" unless self.isa16.length == 1
        # 
        #   # validate values
        #   root.errors << "ISA07 is an invalid value: #{self.isa07} (options are 01 for DUNS and 16 for DUNS+4)" unless self.isa07 == '01' || self.isa07 == '16'
        #   root.errors << "ISA05 is an invalid value: #{self.isa05} (options are 01 for DUNS and 16 for DUNS+4)" unless self.isa05 == '01' || self.isa05 == '16'
        #   root.errors << "ISA14 is an invalid value: #{self.isa14} (options are 1 or 0)" unless self.isa14 == '1' || self.isa14 == '0'
        #   root.errors << "ISA15 is an invalid value: #{self.isa15} (options are T or P)" unless self.isa15 == 'T' || self.isa15 == 'P'
        # 
        #   # validate header length
        #   root.errors << "ISA header is not 106 characters" unless self.to_s.length == VALID_HEADER_LENGTH
        # end
        
        
      end

    end
  end
end