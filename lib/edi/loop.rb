module EDI

  class Loop < Blob

    def segment_count
      children.select{|child| child.segment_count unless child.blank? }.size
    end

    def to_string
      @children.collect do |child|
        child.to_string unless child.blank?
      end.join
    end
    
    def to_human_readable_string
      @children.collect do |child|
        child.to_human_readable_string unless child.blank?
      end.join
    end
    
  end

end