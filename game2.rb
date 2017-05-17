class Game2
  # https://en.wikipedia.org/wiki/Ten-pin_bowling#Scoring
  def initialize
    @rolls = []
  end

  # simply record the rolls pins
  def roll(pins)
    raise ArgumentError, 'Game Closed' if @rolls.length == 21
    @rolls << pins
  end

  # Calculate the score, map the 'rolls' to the frames 
  def score
    map_rolls_to_frames.inject(0) {|a,v| a+ v.frame_total}
  end

  # Structure holds the Frame data
  Frame = Struct.new(:index, :roll_1, :roll_2, :roll_3, :next_frame) do
    
    def last_frame?
      index == 10
    end

    def strike?
      !last_frame? && roll_1 == 10
    end

    def spare?
      !last_frame? && roll_2 != 0 && (roll_1 + roll_2 == 10)
    end

    # Frames 1..9
    def first_two
      roll_1 + roll_2
    end

    # frame total is frame + frame bonus - frame 1..9
    # frame total is roll 1,2,3 - frame 10
    def frame_total
      return last_frame_total if last_frame?

      first_two + frame_bonus
    end

    # Frame bonus, applies if strike? or spare?, 0 otherwise
    def frame_bonus
      return 0 if last_frame?
      
      case
      when strike?
        if next_frame.last_frame? # last frame, add first two elements
          next_frame.first_two 
        elsif next_frame.strike? # next frame is a strike, add 'next-next' element
          next_frame.roll_1 + next_frame.next_frame.roll_1
        else
          next_frame.first_two 
        end
      when spare?
        next_frame.roll_1
      else
        0
      end
    end
    
    # Frame 10
    def last_frame_total
     roll_1 + roll_2 + roll_3
    end
  end
  
  private
  # map rolls to the frames
  def map_rolls_to_frames
    frames = 10.times.map {|i| Frame.new(i+1,0,0,0,nil)}
    # link frames
    (0...9).each {|i| frames[i].next_frame = frames[i+1]}
    (0...8).each {|i| raise "Frame #{i} has no next frame!" if frames[i].next_frame.nil?}
    
    nstrikes = 0 # keep track of the 'strikes'
    @rolls.each_with_index {|e,i|
      
      index_adjusted_by_strikes = i+nstrikes

      if index_adjusted_by_strikes == 20 # last frame, 3rd element
        frames.last.roll_3 = e
      else
        q,r = index_adjusted_by_strikes.divmod(2) # determine frame and the 'roll' index within the frame
        f = frames[q]
        f.send(:"roll_#{r+1}=", e)
        nstrikes +=1 if f.strike? # advance 'nstrikes' if strike
      end
      
    }
    frames
  end
end
