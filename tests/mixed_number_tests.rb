$LOAD_PATH << '.'
require 'fraction.rb'
require 'mixed_number.rb'

class MixedNumberTests
  def initialize
    @from_params = MixedNumber.new("3_2/7")
    @test_fraction = Fraction.new(3, 5)
    @from_block = MixedNumber.new do |m|
      m.whole = 2
      m.fractional_part = Fraction.new do |f|
        f.numerator = 9
        f.denominator = 13
      end
    end
  end

  def run_operation(a, b, op, expected)
    result = a.send(op.to_sym, b)
    if(result.to_string == expected)
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} = #{result.to_string}".green
    else
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} != #{expected}".red
    end
  end

  def chain_operations(expected)
    result = (@from_params * @from_block) + @test_fraction - 2
    if(result.to_string == expected)
      puts "#{@from_params.to_string} * #{@from_block.to_string} + #{@test_fraction.to_string} - 2 = #{result.to_string}".green
    else
      puts "chain result = #{result.to_string} expecting #{expected}".red
    end
  end

  def convert_to_improper_fraction(expected)
    result = @from_params.to_fraction
    if(result.to_string == expected)
      puts "#{@from_params.to_string} as improper fraction = #{result.to_string}".green
    else
      puts "convert result = #{result.to_string} expecting #{expected}".red
    end
  end

  def run_tests
    run_operation @from_params, @from_block, "+", "5_89/91"
    run_operation @from_params, @from_block, "-", "54/91"
    run_operation @from_params, @from_block, "*", "8_11/13"
    run_operation @from_params, @from_block, "/", "1_54/245"

    run_operation @from_params, @test_fraction, "+", "3_31/35"
    run_operation @from_params, @test_fraction, "-", "2_24/35"
    run_operation @from_params, @test_fraction, "*", "1_34/35"
    run_operation @from_params, @test_fraction, "/", "5_10/21"

    run_operation @from_params, 2, "+", "5_2/7"
    run_operation @from_params, 2, "-", "1_2/7"
    run_operation @from_params, 2, "*", "6_4/7"
    run_operation @from_params, 2, "/", "1_9/14"

    convert_to_improper_fraction "23/7"
    chain_operations             "7_29/65"
  end

end
