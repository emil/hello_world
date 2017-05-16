class Game2
  # a little more 'design' oriented version, slightly heavier though.
  
  def initialize
    @rolls = []
  end

  # simply record the rolls pins
  def roll(pins)
    @rolls << pins
  end

  # Calculate the score, map the 'rolls' to the frames 
  def score
    total = 0
    rolls_to_frames = map_rolls_to_frames
    
    rolls_to_frames.each_with_index {|e,i|
      unless e.last_frame?
        if e.strike? # strike, grab the next frame
          next_frame = rolls_to_frames[i+1]
          if next_frame.last_frame? # last frame, add first two elements
            total += next_frame.first_two 
          elsif next_frame.strike? # next frame is a strike, add 'next-next' element
            total += next_frame.roll_1 + rolls_to_frames[i+2].roll_1
          else
            total += next_frame.first_two 
          end
        elsif e.spare?
          total += rolls_to_frames[i+1].roll_1
        end
        total += e.first_two
      else # last frame
        total += e.last_frame_total
      end
    }
    total
  end

  # Structure holds the Frame data
  Frame = Struct.new(:index, :roll_1, :roll_2, :roll_3) do
    
    def last_frame?
      index == 10
    end

    def strike?
      !last_frame? && roll_1 == 10
    end

    def spare?
      !last_frame? && roll_1 != 0 && (roll_1 + roll_2 == 10)
    end

    # Frames 1..9
    def first_two
      roll_1 + roll_2
    end
    
    # Frame 10
    def last_frame_total
     roll_1 + roll_2 + roll_3
    end
  end
  
  private
  # map rolls to the frames
  def map_rolls_to_frames
    frames = 10.times.map {|i| Frame.new(i+1,0,0,0)}

    nstrikes = 0 # keep track of the 'strikes'
    @rolls.each_with_index {|e,i|
      
      index_adjusted_by_strikes = i+nstrikes

      if index_adjusted_by_strikes == 20 # last frame, 3rd element
        frames.last.roll_3 = e
      else
        q,r = index_adjusted_by_strikes.divmod(2) # determine frame and the 'roll' index within the frame
        f = frames[q]
        f.send(:"roll_#{r+1}=", e)
        nstrikes +=1 if e == 10 && !f.last_frame? # advance 'nstrikes' if strike and not the last_frame
      end
      
    }
    frames
  end
end
