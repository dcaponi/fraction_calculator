$LOAD_PATH << '.'
require 'fraction.rb'
require 'mixed_number.rb'

class FractionTests
  def initialize
    @from_params_a = Fraction.new(4, 5)
    @from_params_b = Fraction.new("4", "5")
    @from_block = Fraction.new do |f|
      f.numerator = 2
      f.denominator = 3
    end
  end

  def run_operation(a, b, op, expected)
    result = a.send(op.to_sym, b)
    result.reduce!
    if(result.to_string == expected)
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} = #{result.to_string}".green
    else
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} != #{expected}".red
    end
  end

  def reduce_and_mixed_number
    result = @from_params_a + @from_params_b
    puts "reduce result = #{result.to_mixed_number.to_string} expecting 1_3/5"
  end

  def run_tests
    run_operation @from_params_a, @from_params_b, "+", "8/5"
    run_operation @from_params_a, @from_params_b, "-", "0"
    run_operation @from_params_a, @from_params_b, "*", "16/25"
    run_operation @from_params_a, @from_params_b, "/", "1"

    run_operation @from_params_a, 1, "+", "9/5"
    run_operation @from_params_a, 1, "-", "-1/5"
    run_operation @from_params_a, 2, "*", "8/5"
    run_operation @from_params_a, 2, "/", "2/5"
  end
end
