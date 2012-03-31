module EDI
  class Interchange < Blob

    attr_accessor :groups

    def initialize(options, root, parent)
      super
      @options[:control_number] || parent.interchanges.to_a.size + 1
      @groups = []
    end

    def valid?
      @groups.map(&:valid?).all?
    end

  end
end