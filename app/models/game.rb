class Game < ActiveRecord::Base
  has_many :frames

  validates :score, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 300 }
  validates :handicap, numericality: { only_integer: true,
                                       allow_blank: true }

  def score_game

  end
end
