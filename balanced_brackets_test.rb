require 'minitest/autorun'

class BalancedBracketsTest < MiniTest::Test
  def test_balanced_brackets_one
    assert_equal 0, hasBalancedBrackets('(h[e{lo}!]~)()()()(')
  end

  def test_balanced_brackets
    assert_equal 1, hasBalancedBrackets('[](){}<>')
  end

  def hasBalancedBrackets(str)
    return 1 if str.nil? || str == ''
    stack_brackets = []
    str.chars.each {|c|
      if  ['(', '[', '{', '<'].include?(c)
        stack_brackets << c
      elsif [')', ']', '}', '>'].include?(c)
        case c
        when ')'
          return 0 unless stack_brackets.pop == '('
        when ']'
          return 0 unless stack_brackets.pop == '['
        when '}'
          return 0 unless stack_brackets.pop == '{'
        when '>'
          return 0 unless stack_brackets.pop == '<'
        end
      end
    }
    stack_brackets.length == 0 ? 1 : 0
  end

end

