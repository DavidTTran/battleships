require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/cell'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal [], @game.player_ships
    assert_equal [], @game.computer_ships
    assert_nil @game.player_board
    assert_nil @game.computer_board
  end

  def test_it_can_setup_board
    @game.stubs(:user_input).returns(6)
    @game.board_setup

    assert_equal ["A", "B", "C", "D", "E", "F"], @game.board_setup
    assert_instance_of Board, @game.player_board
    assert_instance_of Board, @game.computer_board
  end

end
