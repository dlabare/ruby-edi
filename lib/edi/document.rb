module EDI
  class Document < Blob

    attr_accessor :interchanges

    def initialize(options, root, parent)
      super
      @options[:segment_terminator] ||= '*'
      @options[:element_terminator] ||= '~'
      @options[:sender_id]          ||= ''
      @options[:receiver_id]        ||= ''
      @options[:date]               ||= Time.now.strftime("%y%m%d")
      @options[:time]               ||= Time.now.strftime("%H%M")
      @interchanges = []
    end
    
    def valid?
      # validate terminaters
      raise MalformedDocumentError.new("\"#{@element_terminator}\" is an invalid element terminator") unless @options[:element_terminator].length == 1
      raise MalformedDocumentError.new("\"#{@segment_terminator}\" is an invalid element terminator") unless @options[:segment_terminator].length == 1
    
      @interchanges.map(&:valid?).all?
    end

  end
end