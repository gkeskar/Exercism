class NotANucleotideError < ArgumentError

  def initialize(message = 'The possible nucleotides are A, C, G, and T')
    super
  end

end

class Nucleotide

  NUCLEOTIDES = %w[A C G T]
  EMPTY_HISTOGRAM =
    {
      'A' => 0,
      'T' => 0,
      'C' => 0,
      'G' => 0
    }
  private_constant :EMPTY_HISTOGRAM

  def self.from_dna(sequence)
    new(sequence)
  end

  private

  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence.chars
    raise NotANucleotideError unless valid?
  end

  def valid?
    sequence.all?{ |c| NUCLEOTIDES.include?(c) }
  end

  public

  def histogram
    return EMPTY_HISTOGRAM if sequence.empty?
    sequence.each_with_object(EMPTY_HISTOGRAM.clone) do |nucleotide,output|
      output[nucleotide] = sequence.count(nucleotide)
    end
  end

  def count(nucleotide)
    sequence.count(nucleotide)
  end

end
