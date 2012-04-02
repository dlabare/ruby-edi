module EDI

  class Loop < Blob

    def segment_count
      children.select{|child| child.segment_count unless child.blank? }.size
    end

    def to_s
      @children.collect do |child|
        child.to_s unless child.blank?
      end.join
    end
    
  end

end