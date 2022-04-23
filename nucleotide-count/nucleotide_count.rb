class CharNotSupportedError < ArgumentError

  def initialize(message = 'Char does not incude in supported Nucleotide')
    super
  end

end

class Nucleotide

  attr_reader :input

  def initialize(input)
    raise CharNotSupportedError unless input.chars.all?{|c| ['A', 'C', 'G', 'T'].include?(c)}
    @input = input
  end

  def self.from_dna(input)
    new(input)
  end

  def histogram
    empty_histogram  = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
    return empty_histogram if input == ""
    input.chars.inject(empty_histogram) do | output, nucleotide |
      output[nucleotide] = input.count(nucleotide)
      output
    end
  end

  def count(char)
    input.count(char)
  end

end
