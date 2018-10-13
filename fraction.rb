
class Fraction
  attr_accessor :whole
  attr_accessor :numerator
  attr_accessor :denominator

  def initialize(str_input = nil)
    if str_input
      if !str_input.include?('/') # Whole number only
        @whole = str_input.to_i
        @numerator = 0
        @denominator = 1
      else
        parts = str_input.split('_')
        @whole = parts.length > 1 ? parts.first.to_i : 0
        fractional_parts = parts.last.split('/')
        @numerator = fractional_parts.first.to_i
        @denominator = fractional_parts.last.to_i
      end
    end
    yield self if block_given?
    raise "Divide by zero exception" if @denominator.zero?
  end

  def +(fraction)
    to_improper_fraction!
    fraction.to_improper_fraction!
    result = Fraction.new do |f|
      f.whole = 0
      f.numerator = (@numerator * fraction.denominator) + (@denominator * fraction.numerator)
      f.denominator = @denominator * fraction.denominator
    end
  end

  def -(fraction)
    to_improper_fraction!
    fraction.to_improper_fraction!
    result = Fraction.new do |f|
      f.whole = 0
      f.numerator = (@numerator * fraction.denominator) - (@denominator * fraction.numerator)
      f.denominator = @denominator * fraction.denominator
    end
  end

  def *(fraction)
    to_improper_fraction!
    fraction.to_improper_fraction!
    result = Fraction.new do |f|
      f.whole = 0
      f.numerator = @numerator * fraction.numerator
      f.denominator = @denominator * fraction.denominator
    end
  end

  def /(fraction)
    to_improper_fraction!
    fraction.to_improper_fraction!
    result = Fraction.new do |f|
      f.whole = 0
      f.numerator = @numerator * fraction.denominator
      f.denominator = @denominator * fraction.numerator
    end
  end

  def print
    if !@whole.zero?
      if !@numerator.zero?
        "#{@whole}_#{@numerator}/#{@denominator}"
      else
        "#{@whole}"
      end
    else
      "#{@numerator}/#{@denominator}"
    end
  end

  def to_mixed_number
    result = Fraction.new do |f|
      f.whole = @numerator / @denominator
      f.numerator = @numerator % @denominator
      f.denominator = @denominator
    end
  end

  def to_improper_fraction
    result = Fraction.new do |f|
      f.whole = 0
      f.numerator = @denominator * @whole + @numerator
      f.denominator = @denominator
    end
  end

  def to_mixed_number!
    fraction = self.to_mixed_number
    @whole = fraction.whole
    @numerator = fraction.numerator
    @denominator = fraction.denominator
    self
  end

  def to_improper_fraction!
    fraction = self.to_improper_fraction
    @whole = fraction.whole
    @numerator = fraction.numerator
    @denominator = fraction.denominator
    self
  end

end
