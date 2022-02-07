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
    9 => 'nine',  19 => 'nineteen',  100 => 'hundred'
  }

  def in_english
    case num_of_digits
    when 1
      ones
    when 2
      tens
    else
      greater_than_tens
    end
  end

  private

  attr_reader :number

  def initialize(number)
    @number = number
    raise ArgumentError.new() if number < 0
    raise ArgumentError.new() if num_of_digits > 12
  end

  def digits
    number.digits.reverse
  end

  def num_of_digits
    digits.count
  end

  def ones
    NUMBER_TO_CARDINAL[number]
  end

  def tens
    NUMBER_TO_CARDINAL[number] || NUMBER_TO_CARDINAL[(digits.first * 10)] + "-" + NUMBER_TO_CARDINAL[digits.last]
  end

  def slices(n)
    digits.reverse.each_slice(n).to_a.map{ |slice| slice.reverse.filter(&:nonzero?) }
  end

  def greater_than_tens
    num_of_digits == 3 ? slices = slices(2) : slices = slices(3)

    slices.reduce("") do | output, slice |
      case slices.index(slice)
      when 0
        word = ""
      when 1
        num_of_digits == 3 ? word = " hundred " : word = " thousand " 
      when 2
        word = " million "
      when 3
        word = " billion "
      end
      slice.empty? ? output : '%s%s%s' % [Say.new(slice.join.to_i).in_english, word, output]
    end.strip
  end
end
