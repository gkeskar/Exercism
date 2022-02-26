class PalindromeFactor

  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = [factors]
  end

  def add_factors(factor)
    factors << factor
  end

end

class Palindromes

  private

  attr_reader :bounds, :range

  def initialize(bounds)
    @bounds = bounds
    max_factor = bounds[:max_factor]
    bounds.key?(:min_factor) ? min_factor = bounds[:min_factor] : min_factor = 1
    range = min_factor.upto(max_factor).to_a
    @range = range
    @palindrome_factors = []
  end

  def palindrome?(number)
    number.digits == number.digits.reverse
  end

  def pf_with_value(value)
    @palindrome_factors.find{|pf| pf.value == value}
  end

  public

  def largest
    @palindrome_factors.sort_by{|pf| pf.value}.last
  end

  def smallest
    @palindrome_factors.sort_by{|pf| pf.value}.first
  end

  def generate
    range.repeated_combination(2).each_with_object([]) do |array, result|
      product = array.reduce(:*)
      if  palindrome?(product)
        already_found = pf_with_value(product)
        already_found ? already_found.add_factors(array) : @palindrome_factors << PalindromeFactor.new(product, array)
      end
    end
  end

end
