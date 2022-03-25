class ColorNotSupportedError < ArgumentError

  def initialize(message = 'Color is not valid')
    super
  end

end

class ResistorColorTrio

  COLOR_CODES = {
     'black'  => 0,
     'brown'  => 1,
     'red'    => 2,
     'orange' => 3,
     'yellow' => 4,
     'green'  => 5,
     'blue'   => 6,
     'violet' => 7,
     'grey'   => 8,
     'white'  => 9
  }

  private

  attr_reader :colors

  def initialize(colors)
    @colors = colors
    raise ColorNotSupportedError unless valid?
  end

  def valid?
    @colors.all?{|color| COLOR_CODES.keys.include?(color)}
  end

  def value_from_band_one_and_two
    colors.first(2).reverse.map.with_index.reduce(0) do |sum , (color, inx)|
      sum + COLOR_CODES[color] * 10 ** inx
    end
  end

  def value_from_band_three
    10 ** COLOR_CODES[colors.last]
  end

  def value_units
    value = value_from_band_one_and_two * value_from_band_three
    queotient, reminder = value.divmod(1000)
    queotient.zero? ? [reminder, "ohms" ] : [queotient, "kiloohms"]
  end

  public

  def label

    value = value_units[0]
    unit = value_units[1]

    result = "%s %s" %[value, unit]
    "Resistor value: #{result}"
  end

end
