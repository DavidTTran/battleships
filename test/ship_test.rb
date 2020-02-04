require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require 'pry'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_new_ship_class_with_attributes
    assert_instance_of Ship, @cruiser
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    refute @cruiser.sunk?
  end

  def test_ship_sinks
    assert_equal 3, @cruiser.health
    refute @cruiser.sunk?
    3.times {@cruiser.hit}
    assert @cruiser.sunk?
  end
end
