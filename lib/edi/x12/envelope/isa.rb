module EDI
  module X12
    module Envelope
      
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
      
      class ISA < EDI::Envelope
        VALID_HEADER_LENGTH = 106

        def initialize(options = {}, root, parent)
          super
          @options[:isa] ||= []
          @options[:iea] ||= []
          @options[:isa][0]  ||= 'ISA'
          @options[:isa][1]  ||= '00'
          @options[:isa][2]  ||= ''.ljust(10)
          @options[:isa][3]  ||= '00'
          @options[:isa][4]  ||= ''.ljust(10)
          @options[:isa][5]  ||= '01'
          @options[:isa][6]  ||= "#{root.options[:sender_id] || ''}".ljust(15)
          @options[:isa][7]  ||= '01'
          @options[:isa][8]  ||= "#{root.options[:receiver_id] || ''}".ljust(15)
          @options[:isa][9]  ||= "#{root.options[:date] || ''}"
          @options[:isa][10] ||= "#{root.options[:time] || ''}"
          @options[:isa][11] ||= 'U'
          @options[:isa][12] ||= root.options[:version] || '00401'
          @options[:isa][13] ||= '1'.rjust(9).gsub(/\s/, '0')
          @options[:isa][14] ||= '0'
          @options[:isa][15] ||= 'T'
          @options[:isa][16] ||= '@'

          @options[:iea][0]  = "IEA"
          @options[:iea][1]  = options[:group_count]
          @options[:iea][2]  = @options[:isa][13] # control number must match
        end

        def valid?
          # validate field lengths
          raise MalformedDocumentError.new("ISA01 is an invalid length: #{@options[:isa][1].length}")  unless @options[:isa][1].length == 2
          raise MalformedDocumentError.new("ISA02 is an invalid length: #{@options[:isa][2].length}")  unless @options[:isa][2].length == 10
          raise MalformedDocumentError.new("ISA03 is an invalid length: #{@options[:isa][3].length}")  unless @options[:isa][3].length == 2
          raise MalformedDocumentError.new("ISA04 is an invalid length: #{@options[:isa][4].length}")  unless @options[:isa][4].length == 10
          raise MalformedDocumentError.new("ISA05 is an invalid length: #{@options[:isa][5].length}")  unless @options[:isa][5].length == 2
          raise MalformedDocumentError.new("ISA06 is an invalid length: #{@options[:isa][6].length}")  unless @options[:isa][6].length == 15
          raise MalformedDocumentError.new("ISA07 is an invalid length: #{@options[:isa][7].length}")  unless @options[:isa][7].length == 2
          raise MalformedDocumentError.new("ISA08 is an invalid length: #{@options[:isa][8].length}")  unless @options[:isa][8].length == 15
          raise MalformedDocumentError.new("ISA09 is an invalid length: #{@options[:isa][9].length}")  unless @options[:isa][9].length == 6
          raise MalformedDocumentError.new("ISA10 is an invalid length: #{@options[:isa][10].length}") unless @options[:isa][10].length == 4
          raise MalformedDocumentError.new("ISA11 is an invalid length: #{@options[:isa][11].length}") unless @options[:isa][11].length == 1
          raise MalformedDocumentError.new("ISA12 is an invalid length: #{@options[:isa][12].length}") unless @options[:isa][12].length == 5
          raise MalformedDocumentError.new("ISA13 is an invalid length: #{@options[:isa][13].length}") unless @options[:isa][13].length == 9
          raise MalformedDocumentError.new("ISA14 is an invalid length: #{@options[:isa][14].length}") unless @options[:isa][14].length == 1
          raise MalformedDocumentError.new("ISA15 is an invalid length: #{@options[:isa][15].length}") unless @options[:isa][15].length == 1
          raise MalformedDocumentError.new("ISA16 is an invalid length: #{@options[:isa][16].length}") unless @options[:isa][16].length == 1

          # validate values
          raise MalformedDocumentError.new("ISA07 is an invalid value: #{@options[:isa][7]} (options are 01 for DUNS and 16 for DUNS+4)") unless @options[:isa][7] == '01' || @options[:isa][7] == '16'
          raise MalformedDocumentError.new("ISA05 is an invalid value: #{@options[:isa][5]} (options are 01 for DUNS and 16 for DUNS+4)") unless @options[:isa][5] == '01' || @options[:isa][5] == '16'
          raise MalformedDocumentError.new("ISA14 is an invalid value: #{@options[:isa][14]} (options are 1 or 0)") unless @options[:isa][14] == '1' || @options[:isa][14] == '0'
          raise MalformedDocumentError.new("ISA15 is an invalid value: #{@options[:isa][15]} (options are T or P)") unless @options[:isa][15] == 'T' || @options[:isa][15] == 'P'

          # validate header length
          raise MalformedDocumentError.new("ISA header is not 106 characters") unless self.header.length == VALID_HEADER_LENGTH

          return true
        end

        def header
          @options[:isa].join(root.options[:element_terminator]) + root.options[:segment_terminator]
        end

        def trailer
          @options[:iea].join(root.options[:element_terminator]) + root.options[:segment_terminator]
        end
      end
    end
    
  end
end