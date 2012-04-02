module EDI
  class Transaction < Envelope

    def control_options
      @options.merge(:control_number => parent.children.size + 1, :child_count => children.map(&:segment_count).inject(:+))
    end

  end
end