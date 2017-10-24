require 'minitest/autorun'

class FibonacciTest < MiniTest::Test
  def test_fibonacci
    assert_equal [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55], (0..10).map {|n| fibonacci(n)}
  end
  
  def test_fibonacci_non_recursive
    assert_equal [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55], (0..10).map {|n| fibonacci_non_recursive(n)}
  end
  private
  
  def fibonacci(n)
    return n if n <= 1
    fibonacci(n - 1) + fibonacci(n - 2)
  end

  def fibonacci_non_recursive(n)
    return n if n <= 1
    # second to last, last
    second_to_last, last = 0,1
    
    (n-1).times do
      last, second_to_last = last + second_to_last, last
    end
    last
  end

end

