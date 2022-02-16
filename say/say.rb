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
    1 => 'one',   11 => 'eleven',    20  => 'twenty',
    2 => 'two',   12 => 'twelve',    30  => 'thirty',
    3 => 'three', 13 => 'thirteen',  40  => 'forty',
    4 => 'four',  14 => 'fourteen',  50  => 'fifty',
    5 => 'five',  15 => 'fifteen',   60  => 'sixty',
    6 => 'six',   16 => 'sixteen',   70  => 'seventy',
    7 => 'seven', 17 => 'seventeen', 80  => 'eighty',
    8 => 'eight', 18 => 'eigtheen',  90  => 'ninety',
    9 => 'nine',  19 => 'nineteen'
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
    max_digits = (1000 ** (powers.to_a.last[0])).digits.count + 2
    raise NaturalNumberError if number < 0
    raise NumberNotSupportedError if number_of_digits > max_digits
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
    (hundredth, tenth) = number.divmod(100)
    hundredth_cardinal = '%s %s ' % [Say.new(hundredth).in_english, 'hundred']
    tenth_cardinal = tenth.nonzero? && Say.new(tenth).in_english
    (hundredth_cardinal + tenth_cardinal.to_s).strip
  end

  def greater_than_hundreds
    slices = number.digits(1000)
    slices.reduce('') do | output, slice |
      slices.index(slice).zero? ? word = "" : word = powers[slices.index(slice)]
      slice.zero? ? output : '%s %s %s' % [Say.new(slice), word, output]
    end.strip
  end

end
