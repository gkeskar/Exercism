class PerfectNumber

  def self.classify(number)
    raise RuntimeError if number < 0
    factors = factors(number)
    return 'perfect' if factors.sum == number
    return 'deficient' if factors.sum < number
    return 'abundant' if factors.sum > number
  end

  def self.factors(number)
    x = 2
    factors = [1]
    a = 1
    while x < number
      a, b = number.divmod(x)

      if b == 0
        factors << x
        x = x + 1
      else
        x = x + 1
      end
    end
    factors
  end
end
