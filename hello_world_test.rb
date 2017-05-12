require 'minitest/autorun'

class HelloWorldTest < MiniTest::Test
  def setup
    # something
  end
  
  def test_hello_world
    flunk
  end

  def test_fibonacci
    assert_equal [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55], (0..10).map {|n| fibonacci(n)}
  end

  private
  
  def fibonacci(n)
    return n if n <= 1 
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

  
