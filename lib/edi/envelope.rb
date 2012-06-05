module EDI
  class Envelope < Blob
    
    attr_accessor :control_header
    attr_accessor :control_trailer
    
    def initialize(options = {}, parent = nil)
      super
    end
    
    def control_options
      @options.merge(:control_number => options[:control_number] || parent.children.size, :child_count => parent.children.size)
    end
        
    def valid?
      super # checks the children
      control_header  && control_header.valid?
      control_trailer && control_trailer.valid?
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