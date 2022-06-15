class NaturalNumberError < RuntimeError

  def initialize(message = 'Not supported a negative number')
    super
  end

end

class PerfectNumber

  def self.classify(number)
    raise RuntimeError if number < 0
    factors = factors(number)
    return 'perfect' if factors.sum == number
    return 'deficient' if factors.sum < number
    return 'abundant' if factors.sum > number
  end

  def self.factors(number)
    (1..number-1).filter{ |num| number%num == 0 }
  end

end
