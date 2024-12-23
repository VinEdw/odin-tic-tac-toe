class Board
  attr_reader :size

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
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
end
