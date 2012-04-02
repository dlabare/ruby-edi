module EDI

  #
  # Possible types
  #
  # N  - Numeric with implied decimal point, signed. Example: N2 indicates a numeric with two decimal places. 12.34 becomes 1234. N0 indicates in integer.
  # R  - Decimal Number with explicit decimal point, signed. Example: 12.34 represented in R format is 12.34. Starting with 4010, exponential notation is also supported.
  # ID - Identifier - A coded value, usually alphanumeric.
  # AN - String - alphanumeric.
  # DT - Date - YYMMDD. As of 4010, CCYYMMDD is also supported.
  # TM - Time - HHMM, with optional seconds and hundredths.
  # B  - Binary - Any sequence of 8 bit bytes.
  #
  class Element < Blob

    MINIMAL_ATTRIBUTES = ['name', 'description', 'ref', 'req', 'type', 'min', 'max', 'value', 'default']

    MINIMAL_ATTRIBUTES.each do |meth|
      define_method(meth) do
        @options[meth.to_sym]
      end
    end

    def value_or_default
      self.value || self.default
    end

    def to_s
      self.value_or_default.to_s
    end

    def required?
      self.req.eql?('M')
    end

    def valid?
      super
      root.errors << "#{self.ref} (#{self.name}) is too short: '#{self.to_s}' - length is #{self.to_s.length}, min is #{self.min}" if required? && (self.to_s.length < self.min)
      root.errors << "#{self.ref} (#{self.name}) is too long: '#{self.to_s}' - length is #{self.to_s.length}, max is #{self.max}"  if self.to_s.length > self.max
    end

  end
end