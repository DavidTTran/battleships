require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board.rb'


class BoardTest < Minitest::Test

  def setup
    @board = Board.new(5)
    @board.create_cells
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_can_have_cells
    assert_instance_of Hash, @board.cells
    assert_equal 25, @board.cells.size
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_it_can_validate_coordinates
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    assert @board.valid_coordinate?("A5")
    assert @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A")
    assert_equal false, @board.valid_coordinate?("Hh")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?("..")
    assert_equal false, @board.valid_coordinate?("a  1")
  end

  def test_it_can_have_invalid_placements
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["C1", "B1", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
  end

  def test_it_can_have_valid_placements
    assert @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert @board.valid_placement?(@submarine, ["A2", "B2"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_it_will_deny_diagonals
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    assert_equal false, @board.valid_placement?(@submarine, ["D2", "E3"])
  end

  def test_it_can_place_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    cell_4 = @board.cells["A4"]

    assert cell_3.ship == cell_2.ship
    assert_equal false, cell_4.ship == cell_3.ship

    assert_nil @board.place(@submarine, ["A3", "A4"])
    assert_nil @board.place(@cruiser, ["A1", "A2", "A4"])
  end

  def test_ships_cannot_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
    assert_equal false, @board.valid_placement?(@submarine, ["A3", "A4"])
    assert @board.valid_placement?(@submarine, ["A4", "B4"])
  end

  def test_board_render_with_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 5\n" +
                 "A . . . . .\n" +
                 "B . . . . .\n" +
                 "C . . . . .\n" +
                 "D . . . . .\n" +
                 "E . . . . .\n", @board.render

    assert_equal "  1 2 3 4 5\n" +
                 "A S S S . .\n" +
                 "B . . . . .\n" +
                 "C . . . . .\n" +
                 "D . . . . .\n" +
                 "E . . . . .\n", @board.render(true)

    @board.place(@submarine, ["C1", "D1"])

    assert_equal "  1 2 3 4 5\n" +
                 "A S S S . .\n" +
                 "B . . . . .\n" +
                 "C S . . . .\n" +
                 "D S . . . .\n" +
                 "E . . . . .\n", @board.render(true)

    @board.place(@cruiser, ["D2", "D3", "D4"])

    assert_equal "  1 2 3 4 5\n" +
                 "A S S S . .\n" +
                 "B . . . . .\n" +
                 "C S . . . .\n" +
                 "D S S S S .\n" +
                 "E . . . . .\n", @board.render(true)
  end

  def test_shots_can_miss
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C1", "D1"])
    cell_1 = @board.cells["D4"]
    cell_2 = @board.cells["C3"]
    cell_1.fire_upon
    cell_2.fire_upon

    assert_equal "  1 2 3 4 5\n" +
                 "A S S S . .\n" +
                 "B . . . . .\n" +
                 "C S . M . .\n" +
                 "D S . . M .\n" +
                 "E . . . . .\n", @board.render(true)
  end

  def test_shots_can_miss
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C1", "D1"])
    cell_1 = @board.cells["D4"]
    cell_2 = @board.cells["C3"]
    cell_1.fire_upon
    cell_2.fire_upon
    assert_equal "  1 2 3 4 5\n" +
                 "A S S S . .\n" +
                 "B . . . . .\n" +
                 "C S . M . .\n" +
                 "D S . . M .\n" +
                 "E . . . . .\n", @board.render(true)
  end

  def test_shots_can_hit_and_destory_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_1.fire_upon
    cell_2.fire_upon

    assert_equal "  1 2 3 4 5\n" +
                 "A H H . . .\n" +
                 "B . . . . .\n" +
                 "C . . . . .\n" +
                 "D . . . . .\n" +
                 "E . . . . .\n", @board.render
    cell_3 = @board.cells["A3"]
    cell_3.fire_upon

    assert_equal "  1 2 3 4 5\n" +
                 "A X X X . .\n" +
                 "B . . . . .\n" +
                 "C . . . . .\n" +
                 "D . . . . .\n" +
                 "E . . . . .\n", @board.render
  end
end
