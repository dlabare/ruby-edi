module EDI
  
  class Blob
    
    attr_accessor :options, :root, :parent, :children
    
    def initialize(options = {}, parent = nil)
      @options  = HashWithIndifferentAccess.new(options)
      @parent   = parent
      @children = []
    end
    
    def add_child(child)
      child.parent = self
      @children << child
      return child
    end
    
    def root
      p = parent
      return p.nil? ? self : p.root
    end

    def segment_terminator
      '~'
    end
    
    def element_terminator
      '*'
    end
    
    def to_s
      @children.map(&:to_s).join
    end
    
    def print
      puts self.to_s
    end
    
    def valid?
      @children.map(&:valid?).all?
    end
    
    def method_missing(method, *args)
      if @options.has_key?(method.to_sym)
        return @options[method.to_sym]
      elsif parent
        parent.send(method)
      else
        super
      end
    end
    
  end
end