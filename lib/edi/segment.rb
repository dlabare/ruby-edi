module EDI
  class Segment < Blob
    
    def segment_count
      1
    end
    
    def blank?
      children.collect{|c| c.blank? }.all?
    end
    
    def to_string
      ([self.class.name.split('::').last] + children.map(&:to_string)).join(root.element_terminator) + root.segment_terminator + "\n"
    end
    
    def to_human_readable_string
      children.map(&:to_human_readable_string).append("-------------\n")
    end
    
    def print
      puts self.to_string
    end

  end
end