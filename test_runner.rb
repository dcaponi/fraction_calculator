$LOAD_PATH << './tests'
require 'fraction_tests.rb'
require 'mixed_number_tests.rb'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'colorize'
end

puts 'Gems installed and loaded!'

fraction_tests = FractionTests.new
mixed_number_tests = MixedNumberTests.new

puts "Fraction Tests"
fraction_tests.run_tests
puts
puts "Mixed Number Tests"
mixed_number_tests.run_tests
