require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'


class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_can_have_cells
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.size
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_it_can_validate_coordinates
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end
  
  def test_it_can_have_invalid_placements
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
  end

  def test_it_can_have_valid_placements
    assert @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert @board.valid_placement?(@submarine, ["A2", "B2"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
  end


  def test_it_will_deny_diagonals
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
    refute @board.valid_placement?(@submarine, ["D2", "E3"])
  end
end
