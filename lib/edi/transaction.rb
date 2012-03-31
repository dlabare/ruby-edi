module EDI
  class Transaction < Blob

    def initialize(options, root, parent)
      super
      @segments = []
    end

    def valid?
      @segments.map(&:valid?).all?
    end

  end
end