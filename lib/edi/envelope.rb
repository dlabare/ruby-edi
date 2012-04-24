module EDI
  class Envelope < Blob
    
    def initialize(options = {}, parent = nil)
      super
    end
    
    def control_options
      @options.merge(:control_number => parent.children.size + 1, :child_count => children.size)
    end
    
    def control_header
    end
    
    def control_trailer
    end
    
    def valid?
      super # checks the children
      control_header.valid?
      control_trailer.valid?
    end
    
    def to_string
      control_header.to_string +
      @children.map(&:to_string).join +
      control_trailer.to_string
    end
    
    def print
      puts self.to_string
    end
    
  end
end