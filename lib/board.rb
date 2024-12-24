class Board
  attr_reader :size

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
  end

  def max_position
    size * size - 1
  end

  def valid_position?(position)
    position.between?(0, max_position)
  end

  def row(index)
    @grid[index].dup
  end

  def column(index)
    @grid.map { |row| row[index] }
  end

  def diagonal(index)
    arr = []

    if index == 0
      (0...size).each do |index|
        arr << @grid.dig(index, index)
      end
    elsif index == 1
      (0...size).each do |index|
        arr << @grid.dig(size - index - 1, index)
      end
    else
      return nil
    end

    arr
  end

  def cell(position)
    row_index, column_index = position_to_coordinates(position)
    @board.dig(row_index, column_index)
  end

  def coordinates_to_position(row_index, column_index)
    row_index * size + column_index
  end

  def position_to_coordinates(position)
    row_index = position / size
    column_index = position % size
    [row_index, column_index]
  end

  def place_marker(position, marker)
    row_index, column_index = position_to_coordinates(position)
    @grid[row_index][column_index] = marker
  end

  def winner
    for marker in [:x, :o]
      (0...size).each do |index|
        return marker if row(index).all?(marker)
        return marker if column(index).all?(marker)
      end

      (0..1).each do |index|
        return marker if diagonal(index).all?(marker)
      end
    end

    nil
  end

  def to_s(horizontal_padding = 2, vertical_padding = 1)
    result = ''

    horizontal_line = '─'
    vertical_line = '│'
    line_intersection = '┼'

    max_digit_width = Math.log10(max_position).floor + 1
    cell_width = max_digit_width + 2 * horizontal_padding
    last_index = size - 1

    filler_row = ((' ' * cell_width + vertical_line) * size).chop + "\n"
    horizontal_cell_divider = ((horizontal_line * cell_width + line_intersection) * size).chop + "\n"

    @grid.each_with_index do |row, row_index|
      vertical_padding.times { result << filler_row }

      row.each_with_index do |marker, column_index|
        marker = @grid.dig(row_index, column_index)
        position = coordinates_to_position(row_index, column_index)

        result << ' ' * horizontal_padding
        result << (marker ? marker : position).to_s.rjust(max_digit_width)
        result << ' ' * horizontal_padding

        result << (column_index == last_index ? "\n" : vertical_line)
      end

      vertical_padding.times { result << filler_row }
      result << horizontal_cell_divider unless row_index == last_index
    end

    result
  end
end
