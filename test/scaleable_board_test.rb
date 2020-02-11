require 'minitest/autorun'
require 'minitest/pride'
require './sandbox/refactoring_sandbox.rb'

class ScaleableBoardTest < Minitest::Test
  def setup
    @board = Board.new(4)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_size
    assert_equal 0, @board
  end
end
