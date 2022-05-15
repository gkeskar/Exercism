class NotANucleotideError < ArgumentError

  def initialize(message = 'Must use a nucleotide.')
    super
  end

end

class Nucleotide

  NUCLEOTIDES = %w[A C G T]
  HISTOGRAM =
    {
      'A' => 0,
      'T' => 0,
      'C' => 0,
      'G' => 0
    }
  private_constant :HISTOGRAM

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
    sequence.all?{ |nucleotide| NUCLEOTIDES.include?(nucleotide) }
  end

  public

  def histogram
    sequence.each_with_object(HISTOGRAM.clone) do |nucleotide, histogram|
      histogram[nucleotide] = sequence.count(nucleotide)
    end
  end

  def count(nucleotide)
    sequence.count(nucleotide)
  end

end
