class Game
  def initialize
    @total = 0
    @count = 0
    @prev_spare = 0
    @spare_multiplier = 1
    @strikes_count = 0
  end

  def roll(pins)
    @total += (pins * @spare_multiplier) # apply 'spare' multiplier

    if @strikes_count > 0 # have we recorded a 'strike'?
      @total += pins
      @strikes_count -=1 # decrease 'strike'
    end
    
    @count +=1
    @spare_multiplier = 1 # reset default 'spare' multiplier
    
    if @count % 2 == 0 # check for 'spare', only on the 2nd roll
      if @prev_spare + pins == 10 # 'spare' condition
        @spare_multiplier = 2
      end
      @prev_spare = 0
    else # 1st roll, check if 'strike'
      if pins == 10 # 'strike'
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
