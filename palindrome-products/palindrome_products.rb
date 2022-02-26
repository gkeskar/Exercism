class PalindromeAccessor

  def initialize(value, factors)
    @value = value
    @factors = [factors]
  end

  attr_reader :value, :factors

  def add_factors(factor)
    factors << factor
  end

end

class Palindromes

  private

  def initialize(min_factor: 1, max_factor:)
    @range = min_factor.upto(max_factor).to_a
    @factors = []
  end

  def is_palindrome?(number)
    number.digits == number.digits.reverse
  end

  def palindrome_has_a_value(value)
    @factors.find{ |palindrome| palindrome.value == value }
  end

  def generate_palindromes
    @range.repeated_combination(2).each_with_object([]) do |combination, result|
      product = combination.reduce(:*)
      if  is_palindrome?(product)
        found = palindrome_has_a_value(product)
        found ? found.add_factors(combination) : @factors << PalindromeAccessor.new(product, combination)
      end
    end
  end

  public

  def largest
    @largest ||= @factors.sort_by{ |palindrome| palindrome.value }.last
  end

  def smallest
    @smallest ||= @factors.sort_by{ |palindrome| palindrome.value }.first
  end

  def generate
    @palindromes ||= generate_palindromes
  end

end
