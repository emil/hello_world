require 'minitest/autorun'
require_relative 'game'

class HelloWorldTest < MiniTest::Test
  def setup
    # something
  end
  
  def test_one_four_result_five
    g = Game.new
    g.roll 1
    g.roll 4
    assert_equal 5, g.score
  end

  def test_first_three_frames
    g = Game.new
    g.roll 1
    g.roll 4
    
    g.roll 4
    g.roll 5
    
    g.roll 6
    g.roll 4

    g.roll 5
    g.roll 5

    g.roll 10
    
    g.roll 0
    g.roll 1
    
    g.roll 7
    g.roll 3
    
    g.roll 6
    g.roll 4

    g.roll 10

    g.roll 2
    g.roll 8
    assert_equal 127, g.score
  end
  
end

  
