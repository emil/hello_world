require 'minitest/autorun'
require_relative 'bowling_game' # 2nd attempt

class BowlingGameTest < MiniTest::Test

  def test_zero_score
    g = BowlingGame.new
    10.times.each {|i| g.roll 0}
    
    assert_equal 0, g.score
  end

  def test_exeeds_rolls_raises
    g = BowlingGame.new
    21.times.each {|i| g.roll 0}
    assert_raises ArgumentError do
      g.roll 0
    end
  end
  
  def test_actual_game
    g = BowlingGame.new
    [
      [[1,4],5],
      [[4,5],14],
      [[6,4],24],
      [[5,5],39],
      [[10,0,1],61],
      [[7,3],71],
      [[6,4],87],
      [[10,2,8],127],
      [[6],133]
    ].each do |rolls,score|
      rolls.each {|r| g.roll r}
      assert_equal score, g.score
    end
  end


  def test_all_ones_scores_20
    g = BowlingGame.new
    20.times.each {|i| g.roll 1}
    
    assert_equal 20, g.score
  end

  
  def test_perfect_score
    g = BowlingGame.new
    12.times.each {|i| g.roll 10}
    
    assert_equal 300, g.score
  end

end
