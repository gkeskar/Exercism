class Matrix
  private

  attr_reader :input_string

  def initialize(input_string)
    @input_string = input_string
  end

  public

  def rows
    input_string.split("\n").map{ |s| s.split()}.map{ |a| a.map(&:to_i) }
  end

  def columns
    rows.transpose
  end
end
