module EDI
  class Segment < Blob
    
    def segment_count
      1
    end
    
    def blank?
      children.collect{|c| c.to_string.blank? || (c.to_string == c.default.to_s)}.all?
    end
    
    def to_string
      ([self.class.name.split('::').last] + children.map(&:to_string)).join(root.element_terminator) + root.segment_terminator + "\n"
    end
    
    def print
      puts self.to_string
    end

  end
end