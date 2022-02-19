class Triangle

  private

  attr_reader :number_of_rows

  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
  end

  public

  def rows
    output = []
    (1..number_of_rows).each do |row|
      if row == 1
        output << [1]
      else
        last_row = output[row - 2]
        index = 0
        next_row = []
        next_row[0] = last_row.last
        (0..(last_row.count - 2)).each do |index|
          next_row << last_row[index] + last_row[index + 1]
          index =+ 1
        end
        next_row << last_row.last
        output << next_row
      end
    end
    output
  end

end
