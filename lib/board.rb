class Board
  attr_reader :size

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
  end

  def row(index)
    @grid[index].dup
  end
end
