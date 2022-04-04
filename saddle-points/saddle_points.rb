class Matrix

  attr_reader :rows, :columns

  def initialize(numbers)
    @rows =  numbers.split("\n").map { |s| s.split(" ").map(&:to_i)}
    @columns = rows.transpose
  end

  def saddle_points
    rows.each_with_object([]) do |row, saddle_points |
      column = columns[row.index(row.max)]
      if row.max <= column.min
        saddle_points << [rows.index(row),columns.index(column)]
      end
    end
  end

end
