require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists_and_can_return_attributes
    assert_instance_of Cell, @cell
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_cell_is_empty?
    assert @cell.empty?
  end

  def test_cell_can_place_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)

    assert_instance_of Ship, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_ship_can_be_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)

    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    @cell.ship.health
    assert_equal 2, @cell.ship.health
    assert @cell.fired_upon?
  end

  def test_render_without_ship
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_render_with_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
  end

  def test_render_with_dead_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    2.times {cruiser.hit}

    assert cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
