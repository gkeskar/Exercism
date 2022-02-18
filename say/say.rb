class NaturalNumberError < ArgumentError

  def initialize(message = 'Not an integer greater than -1')
    super
  end

end

class NumberNotSupportedError < ArgumentError

  def initialize(message = 'Number is too large')
    super
  end

end

class Say

  NUMBER_TO_CARDINAL = {
    0 => 'zero',  10 => 'ten',
    1 => 'one',   11 => 'eleven',
    2 => 'two',   12 => 'twelve',    20  => 'twenty',
    3 => 'three', 13 => 'thirteen',  30  => 'thirty',
    4 => 'four',  14 => 'fourteen',  40  => 'forty',
    5 => 'five',  15 => 'fifteen',   50  => 'fifty',
    6 => 'six',   16 => 'sixteen',   60  => 'sixty',
    7 => 'seven', 17 => 'seventeen', 70  => 'seventy',
    8 => 'eight', 18 => 'eigtheen',  80  => 'eighty',
    9 => 'nine',  19 => 'nineteen',   90  => 'ninety'
  }

  POWERS_OF_THOUSANDS = {
    1 => 'thousand',
    2 => 'million',
    3 => 'billion'
  }

  private

  attr_reader :number, :powers

  def initialize(number, powers = POWERS_OF_THOUSANDS)
    @number = number
    @powers = powers
    valid?
  end

  def valid?
    max_digits = (1000**powers.keys.last).digits.count + 2
    number >= 0 or raise NaturalNumberError
    number_of_digits <= max_digits or raise NumberNotSupportedError
  end

  def digits
    number.digits.reverse
  end

  def number_of_digits
    digits.count
  end

  def ones
    NUMBER_TO_CARDINAL[number]
  end

  def tens
    NUMBER_TO_CARDINAL[number] ||
      '%s-%s' % [NUMBER_TO_CARDINAL[(digits.first * 10)], NUMBER_TO_CARDINAL[digits.last]]
  end

  def hundreds
    hundredth, tenth = number.divmod(100)
    hundredth_cardinal = '%s %s ' % [Say.new(hundredth).in_english, 'hundred']
    tenth_cardinal = tenth.nonzero? && Say.new(tenth).in_english
    (hundredth_cardinal + tenth_cardinal.to_s).strip
  end

  def greater_than_hundreds
    slices = number.digits(1000)
    slices.each_with_index.reduce('') do |output, (slice, index)|
      index.zero? ? word = "" : word = powers[index]
      slice.zero? ? output : '%s %s %s' % [Say.new(slice), word, output]
    end.strip
  end

  public

  def in_english
    case number_of_digits
    when 1
      ones
    when 2
      tens
    when 3
      hundreds
    else
      greater_than_hundreds
    end
  end

  alias :to_s :in_english

end

if $PROGRAM_NAME == __FILE__
  expanded_use = {
    1 => 'thousand',
    2 => 'million',
    3 => 'billion',
    4 => 'trillion',
    5 => 'quadrillion',
    6 => 'quintillion',
    7 => 'sextillion',
    8 => 'septillion'
  }
  puts Say.new(1_234_567_890_123_456_789_123_456, expanded_use )
end
