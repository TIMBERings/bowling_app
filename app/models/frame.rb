class Frame < ActiveRecord::Base
  belongs_to :game

  validates :first, presence: true
  validates :frame, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 12 }

  validates_format_of :first, with: /\A((x|X)|(f|F)|(s|S)?[0-9]{1}|10)\z/
  validates_format_of :second, with: /\A((x|X)|(f|F)|[0-9]{1}|10||\/)\z/, allow_blank: true

  before_save :convert_first
  before_save :convert_second if self.second.present?

  def total
    total = second.presence ? convert_first + convert_second : convert_first unless twelfth?
    total = convert_first if twelfth?
    total
  end

  def strike?
    first.to_i == 10
  end

  def spare?
    return false unless second.presence
    first.to_i != 10 && first.to_i + second.to_i == 10
  end

  def open?
    !strike? && !spare?
  end

  def fill?
    !open?
  end

  def twelfth?
    frame == 12
  end

  def eleventh?
    frame == 11
  end

  def convert_first
    self.split = true if self.first.downcase.include? 's'
    self.first = Frame.convert_to_number(self.first)
  end

  def convert_second
    self.second = self.second == '/' ? 10 - self.first.to_i : Frame.convert_to_number(self.second)
  end

  private

  def self.convert_to_number(string)
    return 0 if string.downcase == 'f'
    return 10 if string.downcase == 'x'
    /(\d{1,2})/.match(string).to_a[0].to_i
  end
end
