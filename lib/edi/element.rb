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

    MINIMAL_ATTRIBUTES = ['title', 'description', 'ref', 'req', 'type', 'min', 'max', 'value', 'default', 'alternate']

    MINIMAL_ATTRIBUTES.each do |meth|
      define_method(meth) do
        @options[meth.to_s]
      end
    end

    def try_alternate
      self.send(alternate.to_s)
    rescue NoMethodError
      return ''
    end

    #
    # Note that if the value and the default are both blank it will pass the 
    # method up the chain for cases like date, time, sender_id, that may be
    # set on the root document
    #
    def value_or_default
      self.value || self.default || self.try_alternate
    end
    
    def blank?
      self.value_or_default.blank? || self.value_or_default == self.default
    end

    def to_string
      val = self.value_or_default
      
      if required?
        case type
        when 'AN'
          return val.to_s.ljust(min)
        when 'N0'
          return "%0#{min}d" % val.to_i
        end
      end
      # end if required?
      
      case type
      when 'DT'
        return val.strftime("#{min == 8 ? '%Y' : '%y'}%m%d") if val.is_a?(Date)
      when 'TM'
        return val.strftime("%H%M") if val.is_a?(Time)
      end
      
      return val.to_s
    end
    
    def to_human_readable_string
      return '' if value.blank?
      
      val = value
      
      if type == 'N2'
        # Implied decimal, let's normalize it
        val = ("%0.2f" % (val.to_f / 100)) if type == 'N2'
      end
      
      str = "#{title}: #{val}"
      
      # If there's a description for the ID, let's list that too
      if type == 'ID'
        begin
          code_desc = acceptable_values[value]
          str += " (#{code_desc})" unless code_desc.blank?
        rescue NoMethodError
        end
      end
      
      return "#{str}\n"
    end

    def required?
      self.req.eql?('M')
    end

    def valid?
      super
      root.errors << "#{self.ref} (#{self.ref}) is too short: '#{self.to_string}' - length is #{self.to_string.length}, min is #{self.min}" if required? && (self.to_string.length < self.min.to_i)
      root.errors << "#{self.ref} (#{self.ref}) is too long: '#{self.to_string}' - length is #{self.to_string.length}, max is #{self.max}"  if self.to_string.length > self.max.to_i
    end

  end
end