module EDI
  class Group < Blob

    def initialize(options, root, parent)
      super
      @transactions = []
    end

    def valid?
      @transactions.map(&:valid?).all?
    end

  end
end