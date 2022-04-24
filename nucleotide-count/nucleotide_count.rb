class NucleotideNotSupportedError < ArgumentError

  def initialize(message = 'The supported nucleotides are A, C, G, and T')
    super
  end

end

class Nucleotide

  def self.from_dna(sequence)
    new(sequence)
  end

  private

  attr_reader :sequence

  def initialize(sequence)
    raise NucleotideNotSupportedError unless sequence.chars.all?{|c| ['A', 'C', 'G', 'T'].include?(c)}
    @sequence = sequence
  end

  public

  def histogram
    empty_histogram  = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
    return empty_histogram if sequence == ""
    sequence.chars.inject(empty_histogram) do | output, nucleotide |
      output[nucleotide] = sequence.count(nucleotide)
      output
    end
  end

  def count(nucleotide)
    sequence.count(nucleotide)
  end

end
