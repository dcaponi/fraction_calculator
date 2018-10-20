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

  def +(other)
    if other.is_a?(Numeric)
      numerator = @numerator + (@denominator * other)
      denominator = @denominator
    else
      numerator = (@numerator * other.denominator) + (@denominator * other.numerator)
      denominator = @denominator * other.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def -(other)
    if other.is_a?(Numeric)
      numerator = @numerator - (@denominator * other)
      denominator = @denominator
    else
      numerator = (@numerator * other.denominator) - (@denominator * other.numerator)
      denominator = @denominator * other.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def *(other)
    if other.is_a?(Numeric)
      numerator = @numerator * other
      denominator = @denominator
    else
      numerator = @numerator * other.numerator
      denominator = @denominator * other.denominator
    end
    Fraction.new(numerator, denominator)
  end

  def /(other)
    if other.is_a?(Numeric)
      numerator = @numerator
      denominator = @denominator * other
    else
      numerator = @numerator * other.denominator
      denominator = @denominator * other.numerator
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
