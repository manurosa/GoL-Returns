require 'test/unit'
require_relative '../board'

class BoardTest < Test::Unit::TestCase
  def test_board_creates_cells
    board = Board.new
    board.create_cells
    assert_equal true, board.board[1][1].is_a?(Cell)
  end
end
