# Fraction Calculator

## Instructions
Clone this repository.
From the command line, run `ruby main.rb`

See these instructions and enter your expression:
```
Enter a mixed-fraction expression with space separated operator.
Limit 2 operands and 1 operator.
Valid operators are + - * and /
Example: 3_1/2 + 2/4
Enter 'exit' or 'quit' to quit.
```

## Input Examples
3_1/2 + 2/3 => 4_1/6

33/2 / 364/2 => 33/364

24_4/3 - 3/9 => 25

#### Operating Assumptions:
Only whole integers will make up the expression
Only integers, valid operators and _ will be allowed in expression
The expression will contain only 2 operands and 1 operator
The operator will have a space on both sides of it

#### Examples of unexpected input:
1.2/2 + 2.2/4 (decimal numbers)

3_1/2*2/9 (missing space)

3 * 2/3 + 4/3 (more than 2 operands)

#### Running Tests
Clone this repository.
From the command line, run `ruby test_runner.rb`
Then all the pre-defined test cases will be run.
Green output shows example inputs and results
Red output shows a failing test case, the inputs and expected output
