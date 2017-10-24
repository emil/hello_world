require 'minitest/autorun'
require_relative 'game'  # 1st attempt
require_relative 'bowling_game' # 2nd attempt

class HelloWorldTest < MiniTest::Test
  def setup
    # something
  end

  def test_first_implementation
    g = Game.new
    g.roll 1
    g.roll 4
    assert_equal 5, g.score
    
    g.roll 4
    g.roll 5
    assert_equal 14, g.score
    
    g.roll 6
    g.roll 4
    assert_equal 24, g.score
    
    g.roll 5
    g.roll 5
    assert_equal 39, g.score
    
    g.roll 10
    assert_equal 59, g.score
    
    g.roll 0
    g.roll 1
    assert_equal 61, g.score
    
    g.roll 7
    g.roll 3
    assert_equal 71, g.score
    
    g.roll 6
    g.roll 4
    assert_equal 87, g.score
    
    g.roll 10
    assert_equal 107, g.score
    
    g.roll 2
    g.roll 8
    assert_equal 127, g.score
  end
  
  def test_second_implementation
    g = BowlingGame.new
    g.roll 1
    g.roll 4
    assert_equal 5, g.score
    
    g.roll 4
    g.roll 5
    assert_equal 14, g.score
    
    g.roll 6
    g.roll 4
    assert_equal 24, g.score
    
    g.roll 5
    g.roll 5
    assert_equal 39, g.score
    
    g.roll 10
    g.roll 0
    g.roll 1
    assert_equal 61, g.score
    
    g.roll 7
    g.roll 3
    assert_equal 71, g.score
    
    g.roll 6
    g.roll 4
    assert_equal 87, g.score
    
    g.roll 10
    g.roll 2
    g.roll 8
    assert_equal 127, g.score
    
    g.roll 6
    assert_equal 133, g.score
  end

  def test_game2_perfect_score
    g = BowlingGame.new
    12.times.each {|i| g.roll 10}
    
    assert_equal 300, g.score
  end

  def test_game2_zero_score
    g = BowlingGame.new
    10.times.each {|i| g.roll 0}
    
    assert_equal 0, g.score
  end

  def test_game2_exeeds_rolls_raises
    g = BowlingGame.new
    21.times.each {|i| g.roll 0}
    assert_raises ArgumentError do
      g.roll 0
    end
  end

  def test_game2_all_ones_scores_20
    g = BowlingGame.new
    20.times.each {|i| g.roll 1}
    
    assert_equal 20, g.score
  end
end
