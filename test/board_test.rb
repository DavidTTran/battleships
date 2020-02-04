require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'


class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_can_have_cells
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.size
    assert_instance_of Cell, @board.cells["A1"]
  end
end
