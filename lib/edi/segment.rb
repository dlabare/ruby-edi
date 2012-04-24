module EDI
  class Segment < Blob
    
    def segment_count
      1
    end
    
    def blank?
      children.collect{|c| c.to_s.blank? || (c.to_s == c.default.to_s)}.all?
    end
    
    def print
      puts self.to_s
    end
    
    def to_s
      ([self.class.name.split('::').last] + children.map(&:to_s)).join(root.element_terminator) + root.segment_terminator + "\n"
    end
        
  end
end