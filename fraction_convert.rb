module FractionConvert

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
