######################################################

# Bowling Game Kata with ruby implimentation
# from butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata

######################################################

class Game

  def initialize
    @rolls = []
    @current_roll = 0
  end

  def roll(pins)
    @rolls[@current_roll] = pins
    @current_roll += 1
  end

  def score
    score = 0
    frame = 0

    10.times do
      if strike?(frame)
        score += 10 + strike_bonus(frame)
        frame += 1
      elsif spare?(frame)
        score += 10 + spare_bonus(frame)
        frame += 2
      else
        score += sum_of_balls_in_frame(frame)
        frame += 2
      end
    end
    return score
  end

  private
  def sum_of_balls_in_frame(frame)
    @rolls[frame] + @rolls[frame + 1]
  end

  def strike_bonus(frame)
    @rolls[frame + 1] + @rolls[frame + 2]
  end

  def spare_bonus(frame)
    @rolls[frame + 2 ]
  end

  def strike?(frame)
    @rolls[frame] == 10
  end

  def spare?(frame)
    @rolls[frame] + @rolls[frame + 1] == 10
  end

end
