class NotANucleotideError < ArgumentError

  def initialize(message = 'The possible nucleotides are A, C, G, and T')
    super
  end

end

class Nucleotide

  NUCLEOTIDES = ['A', 'C', 'G', 'T']

  def self.from_dna(sequence)
    new(sequence)
  end

  private

  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence
    raise NotANucleotideError unless valid?
  end

  def valid?
    sequence.chars.all?{|c| NUCLEOTIDES.include?(c)}
  end

  EMPTY_HISTOGRAM = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
  private_constant :EMPTY_HISTOGRAM

  public

  def histogram
    return EMPTY_HISTOGRAM if sequence.empty?
    sequence.chars.inject(EMPTY_HISTOGRAM.clone) do | output, nucleotide |
      output[nucleotide] = sequence.count(nucleotide)
      output
    end
  end

  def count(nucleotide)
    sequence.count(nucleotide)
  end

end
