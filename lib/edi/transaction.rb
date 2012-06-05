module EDI
  class Transaction < Envelope

    # +2 because it includes the ST and SE segments
    def control_options
      @options.merge(:control_number => options[:control_number] || parent.children.size, :child_count => children.map(&:segment_count).inject(:+).to_i + 2)
    end

  end
end