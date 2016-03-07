class Frame < ActiveRecord::Base
  belongs_to :game

  validates :first, presence: true
  validates :frame, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 12 }

  validates_format_of :first, with: /^((f|F)|(s|S)?[0-9]{1}|10)$/, multiline: true
  validates_format_of :second, with: /^((f|F)|[0-9]{1}|10)$/, allow_blank: true, multiline: true

  def total
    total = second.presence ? convert_first + convert_second : convert_first unless twelfth?
    total = convert_first if twelfth?
    total
  end

  def strike?
    convert_first == 10
  end

  def spare?
    return false unless second.presence
    convert_first != 10 && convert_first + convert_second == 10
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
    Frame.convert_to_number(first)
  end

  def convert_second
    Frame.convert_to_number(second)
  end

  def self.convert_to_number(string)
    0 if string.downcase == 'f'
    /(\d{1,2})/.match(string).to_a[0].to_i
  end
end
