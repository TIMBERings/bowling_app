class Game < ActiveRecord::Base
  attr_accessor :score_map

  has_many :frames

  validates :score, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 300 }
  validates :handicap, numericality: { only_integer: true,
                                       allow_blank: true }

 def finalize_game
    score_game
    total_frames
  end

  private

  def score_game
    @score_map = []
    self.frames.each_with_index do |frame, index|
      running_total = @score_map[-1] ? @score_map[-1] : 0
      if index <= 8
        total_normal_frame(frame, running_total, index) if index
      elsif index == 9
        total_tenth_frame
      end
    end
    self.score = @score_map[-1]
  end

  def total_normal_frame(frame, running_total, index)
    if frame.strike?
      @score_map.push(running_total + score_strike(index))
    elsif frame.spare?
      @score_map.push(running_total + score_spare(index))
    else
      @score_map.push(running_total + score_open(index))
    end
  end

  def total_tenth_frame
    tenth_frame = self.frames[9]
    eleventh_frame = self.frames[10]
    twelfth_frame = self.frames[11]

    score = 0
    score += tenth_frame.first.to_i
    score += tenth_frame.second.to_i if tenth_frame.second.present?
    score += eleventh_frame.first.to_i if eleventh_frame && eleventh_frame.first.present?
    score += eleventh_frame.second.to_i if eleventh_frame && eleventh_frame.second.present?
    score += twelfth_frame.first.to_i if twelfth_frame && twelfth_frame.first.present?

    @score_map.push(@score_map[-1] + score)
  end

  def total_frames
    self.frames.each_with_index do |frame, index|
      frame.score = @score_map[index] if index <= 9
    end
  end

  def score_strike(index)
    frame = self.frames[index + 1]
    next_frame = self.frames[index + 2]
    10 + frame.first.to_i + (frame.second ? frame.second : next_frame.first).to_i
  end

  def score_spare(index)
    10 + self.frames[index + 1].first.to_i
  end

  def score_open(index)
    self.frames[index].first.to_i + self.frames[index].second.to_i
  end

end
