# https://en.wikipedia.org/wiki/Ten-pin_bowling#Scoring
class Game2
  # Initialize the Game, empty rolls array, and setup the Frames
  def initialize
    @rolls = []
    setup_frames
  end

  # simply record the rolls pins
  def roll(pins)
    raise ArgumentError, 'Game Closed' if @rolls.length == 21
    @rolls << pins
  end

  # Calculate the score, sum each frame total
  def score
    populate_frames.inject(0) {|a,v| a+ v.frame_total}
  end

  # Structure holds the Frame data, determies the 'type' of the frame (strike?, spare?) and calculates the score total and bonus
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
      if last_frame?
        last_frame_total
      else
        first_two + frame_bonus
      end
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
        0 # no bonus
      end
    end
    
    # Frame 10 total
    def last_frame_total
     roll_1 + roll_2 + roll_3
    end

    def reset
      roll_1 = 0
      roll_2 = 0
      roll_3 = 0
    end
  end
  
  private
  
  # populate the frames from the rolls
  def populate_frames

    # reset the frame roll values
    @frames.each {|f| f.reset }

    nstrikes = 0 # keep track of the 'strikes' as they result in 'skip' to the next frame
    # iterate the rolls array and populate the corresponding frame instances
    @rolls.each_with_index {|e,i|
      
      # add the 'nstrikes'
      index_adjusted_by_strikes = i+nstrikes

      if index_adjusted_by_strikes == 20 # last frame, 3rd element
        @frames.last.roll_3 = e
      else
        q,r = index_adjusted_by_strikes.divmod(2) # determine the frame and the 'roll' index within the frame
        f = @frames[q]
        f.send(:"roll_#{r+1}=", e)
        nstrikes +=1 if f.strike? # increment 'nstrikes' if strike
      end
    }
    @frames
  end

  # Prepare the 10 element array of Frames.
  # - create the 10 elements Frame instance array (if not created already)
  # - frames are 'linked' as a 'linked list' to facilitate score/bonus calculation.
  def setup_frames
    @frames ||=
    begin
      frames = 10.times.map {|i| Frame.new(i+1,0,0,0,nil)}
      # link frames
      (0...9).each {|i| frames[i].next_frame = frames[i+1]}
      frames
    end
  end
  
end
