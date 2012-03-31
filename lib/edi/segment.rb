module EDI
  class Segment < Blob
    
    def print
      @options.join(@transaction.element_terminator) + @transaction.segment_terminator
    end
    
    def valid?
      true
    end
    
  end
end