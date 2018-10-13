$LOAD_PATH << '.'
require 'fraction.rb'
require 'mixed_number.rb'

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
      mixed_number_a = MixedNumber.new(expression.first)
      mixed_number_b = MixedNumber.new(expression.last)
      # Meta: Convert the operator to symbol and call it like a method
      result = mixed_number_a.send(expression[1].to_sym, mixed_number_b)
      puts "result = #{result.to_string}"
    rescue
      puts "one of your operands is trying to divide by zero"
    end

  end
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
