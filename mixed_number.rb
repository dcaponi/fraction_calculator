class MixedNumber
  attr_accessor :whole
  attr_accessor :fractional_part

  def initialize(str_input = nil)
    if str_input
      if !str_input.include?('/') # Whole number only
        @whole = str_input.to_i
        @improper = Fraction.new do |f|
          f.numerator = @whole
          f.denominator = 1
        end
      else
        parts = str_input.split('_')
        @whole = parts.length > 1 ? parts.first.to_i : 0
        fractional_parts = parts.last.split('/')

        @fractional_part = Fraction.new do |f|
          f.numerator = fractional_parts.first.to_i
          f.denominator = fractional_parts.last.to_i
        end
      end
    end
    yield self if block_given?
  end

  def to_fraction
    @improper ||= Fraction.new do |f|
      f.numerator = ( @fractional_part.denominator * @whole ) + @fractional_part.numerator
      f.denominator = @fractional_part.denominator
    end
  end

  # operating on mixed numbers should return a mixed number.
  # The onus is on the caller to convert the mixed number to a fraction if desired.
  def +(mixed_number)
    result = mixed_number.respond_to?(:to_fraction) ?
      self.to_fraction + mixed_number.to_fraction : self.to_fraction + mixed_number
    result.to_mixed_number
  end

  def -(mixed_number)
    result = mixed_number.respond_to?(:to_fraction) ?
      self.to_fraction - mixed_number.to_fraction : self.to_fraction - mixed_number
    result.to_mixed_number
  end

  def *(mixed_number)
    result = mixed_number.respond_to?(:to_fraction) ?
      self.to_fraction * mixed_number.to_fraction : self.to_fraction * mixed_number
    result.to_mixed_number
  end

  def /(mixed_number)
    result = mixed_number.respond_to?(:to_fraction) ?
      self.to_fraction / mixed_number.to_fraction : self.to_fraction / mixed_number
    result.to_mixed_number
  end

  def to_string
    if @fractional_part && !@fractional_part.numerator.zero? && !@whole.zero?
      "#{@whole}_#{@fractional_part.to_string}"
    elsif @whole.zero? && @fractional_part
      "#{@fractional_part.to_string}"
    else
      "#{@whole}"
    end
  end

end
