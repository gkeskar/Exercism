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

  private

  attr_reader :number

  def initialize(number)
    @number = number
    raise ArgumentError.new() if number < 0
    raise ArgumentError.new() if number_of_digits > 12
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
    NUMBER_TO_CARDINAL[number] || NUMBER_TO_CARDINAL[(digits.first * 10)] + "-" + NUMBER_TO_CARDINAL[digits.last]
  end

  def hundreds
    (hundredth, tenth) = number.divmod(100)
    hundredth_cardinal = Say.new(hundredth).in_english  + ' hundred '
    tenth_cardinal = tenth.zero? ? "" : Say.new(tenth).in_english
    (hundredth_cardinal + tenth_cardinal).strip
  end

  def greater_than_hundreds
    slices = number.digits(1000)
    slices.reduce("") do | output, slice |
      case slices.index(slice)
      when 0
        word = ""
      when 1
        word = " thousand "
      when 2
        word = " million "
      when 3
        word = " billion "
      end
      slice.zero? ? output : '%s%s%s' % [Say.new(slice).in_english, word, output]
    end.strip
  end
end
