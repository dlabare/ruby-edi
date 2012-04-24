module EDI
  class Transaction < Envelope

    # +2 because it includes the ST and SE segments
    def control_options
      @options.merge(:control_number => parent.children.size + 1, :child_count => children.map(&:segment_count).inject(:+) + 2)
    end

  end
end