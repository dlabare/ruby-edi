module EDI
  class Transaction < Envelope

    def control_options
      @options.merge(:control_number => options[:control_number] || parent.children.size, :child_count => segment_count)
    end

  end
end