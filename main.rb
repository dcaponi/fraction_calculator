$LOAD_PATH << '.'
require 'fraction.rb'

VALID_OPERATORS = ['+', '-', '*', '/']
EXIT_COMMANDS = ["exit", "quit"]

def main
  quit = false
  puts "Mixed fractional calculator!"

  while !quit
    expression = []

    while expression.length != 3 # expecting 2 operands and 1 operator only
      print_instructions
      expression = gets.chomp.split(' ')

      if EXIT_COMMANDS.include?(expression[0].downcase)
        quit = true
        break
      end

      if expression[1] && !VALID_OPERATORS.include?(expression[1])
        print "\n"
        puts "Illegal operator #{expression[1]}"
        expression = []
      end

    end

    break if quit

    begin
      fraction_a = Fraction.new(expression.first)
      fraction_b = Fraction.new(expression.last)
      # Meta: Convert the operator to symbol and call it like a method
      result = fraction_a.send(expression[1].to_sym, fraction_b)
      print_results(result)
    rescue
      puts "one of your operands is trying to divide by zero"
    end

  end
end

def print_results(result)
  mixed_number_result = result.to_mixed_number
  improper_fraction_result = result.to_improper_fraction

  puts "As Mixed Number #{mixed_number_result.print}"
  puts "As Improper Fraction #{improper_fraction_result.print}"
end

def print_instructions
  puts ""
  puts "Enter a mixed-fraction expression with space separated operator."
  puts "Limit 2 operands and 1 operator."
  puts "Valid operators are + - * and /"
  puts "Example: 3_1/2 + 2/4"
  puts "Enter 'exit' or 'quit' to quit."
  print "Enter your expression: "
end

main
