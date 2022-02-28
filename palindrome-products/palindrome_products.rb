class PalindromeAccessor

  def initialize(value, *factors)
    @value = value
    @factors = factors
  end

  attr_reader :value, :factors

  def add_factors(factor)
    factors << factor
  end

end

class Palindromes

  private

  attr_reader :palindromes, :candidates

  def initialize(min_factor: 1, max_factor:)
    @candidates = min_factor.upto(max_factor).to_a
    @palindromes = []
  end

  def palindrome?(number)
    number.digits == number.digits.reverse
  end

  def palindrome_has_a_value(value)
    palindromes.find { |palindrome| palindrome.value == value }
  end

  def generated_palindromes
    candidates.repeated_combination(2).each_with_object([]) do |combination, result|
      product = combination.reduce(:*)
      if palindrome?(product)
        found = palindrome_has_a_value(product)
        found ?
          found.add_factors(combination) :
          palindromes << PalindromeAccessor.new(product, combination)
      end
    end
    palindromes.sort_by! { |palindrome| palindrome.value }
  end

  public

  def generate
    @generated_palindromes ||= generated_palindromes
  end

  def largest
    @largest ||= palindromes.last
  end

  def smallest
    @smallest ||= palindromes.first
  end

end
