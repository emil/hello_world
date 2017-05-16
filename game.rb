class Game
  def initialize
    @total = 0
    @count = 0
    @prev_spare = 0
    @spare_multiplier = 1
    @strikes_count = 0
  end

  def roll(pins)
    @total += (pins * @spare_multiplier)

    if @strikes_count > 0
      @total += pins
      @strikes_count -=1
    end
    
    @count +=1
    @spare_multiplier = 1
    
    # check for 'spare'
    if @count % 2 == 0
      # 'spare' condition
      if @prev_spare + pins == 10
        @spare_multiplier = 2
      end
      @prev_spare = 0
    else
      if pins == 10 # strike
        @strikes_count = 2
        @count +=1 # immediately over
      else
        @prev_spare = pins
      end
    end
    
  end
  
  def score
    @total
  end
end
