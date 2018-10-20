class MixedNumber
  attr_accessor :whole
  attr_accessor :fractional_part

  def initialize(str_input = nil)
    if str_input
      # if the caller instantiates a mixed_number but only supplies the whole part
      # the class should be flexible enough to handle it as a mixed number with a
      # 0/1 fractional part

      # Integers should be able to be cast as mixed_numbers and used as such, however
      # mixed numbers can be operated on with fractions or integers
      if !str_input.include?('/') # Whole number only
        @whole = str_input.to_i
        @fractional_part = Fraction.new do |f|
          f.numerator = 0
          f.denominator = 1
        end
      else
        parts = str_input.split('_')
        fractional_parts = parts.last.split('/')
        # if the caller instantiates a mixed_number but only supplies the fractional_part
        # the class should be flexible enough to handle it as a mixed number with Whole
        # of 0.
        @whole = parts.length > 1 ? parts.first.to_i : 0
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

  # The to_fraction checks see if we are adding another mixed_number and need to
  # convert it to an improper fraction before calling the operator. Fractions
  # should not have a to_fraction method as they are already fractions

  # We use the respond_to check rather than checking the type here in order to
  # take advantage of duck typing where the input should simply implement
  # the to_fraction method
  def +(other)
    result = other.respond_to?(:to_fraction) ?
      self.to_fraction + other.to_fraction : self.to_fraction + other
    result.to_mixed_number
  end

  def -(other)
    result = other.respond_to?(:to_fraction) ?
      self.to_fraction - other.to_fraction : self.to_fraction - other
    result.to_mixed_number
  end

  def *(other)
    result = other.respond_to?(:to_fraction) ?
      self.to_fraction * other.to_fraction : self.to_fraction * other
    result.to_mixed_number
  end

  def /(other)
    result = other.respond_to?(:to_fraction) ?
      self.to_fraction / other.to_fraction : self.to_fraction / other
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
