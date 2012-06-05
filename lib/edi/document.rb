module EDI
  class Document < Blob

    attr_accessor :errors

    def initialize(options = {}, parent = nil)
      super
      @options[:segment_terminator] ||= '~'
      @options[:element_terminator] ||= '*'
      @options[:sender_id]          ||= ''
      @options[:receiver_id]        ||= ''
      @options[:date]               ||= Date.today
      @options[:time]               ||= Time.now
    end
    
    def interchange
      self.children.first
    end
    
    def valid?
      @errors = []
      super

      # validate terminaters
      unless @options[:element_terminator].length == 1
        @errors << "\"#{@options[:element_terminator]}\" is an invalid element terminator"
      end
      
      unless @options[:segment_terminator].length == 1
        @errors << "\"#{@options[:segment_terminator]}\" is an invalid element terminator"
      end

      return @errors.empty?
    end

  end
end