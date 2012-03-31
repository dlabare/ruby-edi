module EDI
  
  class Blob
    
    attr_accessor :options, :root, :parent
    
    def initialize(options = {}, root, parent)
      @options = options
      @root    = root
      @parent  = parent
    end
    
  end
end