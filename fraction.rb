class Fraction
  attr_accessor :numerator
  attr_accessor :denominator

  def initialize(numerator = nil, denominator = nil)
    if !numerator.nil? && !denominator.nil?
      @numerator = numerator.to_i
      @denominator = denominator.to_i
    end
    yield self if block_given?
    raise "Divide by zero exception" if @denominator.zero?
  end

  def +(fraction)
    if fraction.is_a?(Numeric)
      numerator = @numerator + (@denominator * fraction)
      denominator = @denominator
    else
      numerator = (@numerator * fraction.denominator) + (@denominator * fraction.numerator)
      denominator = @denominator * fraction.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def -(fraction)
    if fraction.is_a?(Numeric)
      numerator = @numerator - (@denominator * fraction)
      denominator = @denominator
    else
      numerator = (@numerator * fraction.denominator) - (@denominator * fraction.numerator)
      denominator = @denominator * fraction.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def *(fraction)
    if fraction.is_a?(Numeric)
      numerator = @numerator * fraction
      denominator = @denominator
    else
      numerator = @numerator * fraction.numerator
      denominator = @denominator * fraction.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def /(fraction)
    if fraction.is_a?(Numeric)
      numerator = @numerator
      denominator = @denominator * fraction
    else
      numerator = @numerator * fraction.denominator
      denominator = @denominator * fraction.numerator
    end
    Fraction.new(numerator, denominator)
  end

  def to_string
    if @numerator.zero?
      "#{@numerator}"
    elsif @numerator == @denominator
      "1"
    else
      "#{@numerator}/#{@denominator}"
    end
  end

  def to_mixed_number
    reduce!
    result = MixedNumber.new do |f|
      f.whole = @numerator / @denominator
      f.fractional_part = Fraction.new(@numerator % @denominator, @denominator)
    end
  end

  def reduce!
    gcd = greatest_common_denominator(@numerator, @denominator)
    @numerator = @numerator / gcd
    @denominator = @denominator / gcd
  end

  private def greatest_common_denominator(a, b)
    return a if b.zero?
    greatest_common_denominator(b, a%b)
  end

end
