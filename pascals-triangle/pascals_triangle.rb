class Triangle

  private

  attr_reader :number_of_rows

  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
  end

  def new_row(head, new_elements, tail)
    new_elements.prepend(head).append(tail)
  end

  def new_elements(last_row)
    number_of_elements = last_row.size - 2
    0.upto(number_of_elements).each_with_object([]).with_index do |(_, array), index|
       array << last_row[index] + last_row[index + 1]
    end
  end

  public

  def rows
    1.upto(number_of_rows).each_with_object([]) do |row, result|
      if row == 1
        result << [1]
      else
        last_row = result[row - 2]
        result << new_row(last_row.first, new_elements(last_row), last_row.last )
      end
    end
  end

end
