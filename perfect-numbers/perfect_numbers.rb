class NaturalNumberError < RuntimeError

  def initialize(message = 'Not supported a negative number')
    super
  end

end

class PerfectNumber

  def self.classify(number)
    raise NaturalNumberError if number < 0
    aliquot_sum = (1...number).filter{ |divisor| number%divisor == 0 }.reduce(0, :+)
    return 'perfect' if aliquot_sum == number
    return 'deficient' if aliquot_sum < number
    return 'abundant' if aliquot_sum > number
  end

end
