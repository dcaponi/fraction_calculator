module OperationRunner

  def run_operation(a, b, op, expected)
    # Meta: calls the + - * or / method on the fraction or mixed number
    result = a.send(op.to_sym, b)
    # Meta: fractions are not reduced by default and must be reduced.
    # mixed numbers do not have a reduce! method, that is the only difference here
    result.reduce! if result.respond_to?(:reduce!)
    if(result.to_string == expected)
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} = #{result.to_string}".green
    else
      puts "#{a.to_string} #{op} #{b.respond_to?(:to_string) ? b.to_string : b} != #{expected}; got #{result.to_string}".red
    end
  end

end
