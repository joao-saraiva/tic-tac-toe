# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/player"
require_relative "../lib/tic_tac_board"

class TicTacBoardTest < MiniTest::Test
  def setup
    @player_with_x = Player.new("X")
    @player_with_o = Player.new("O")
    
    @tic_tac_board = TicTacBoard.new([@player_with_x, @player_with_o])
  end

  def test_player_limit_is_2
    assert_raises(StandardError, "Need to be 2 players") {Board.new([@player_with_x, @player_with_o, @player_with_x])}
    assert_raises(StandardError, "Need to be 2 players") {Board.new([])}

  end

  def test_board_is_initialized_on_tic_tac_toe_format
    assert_equal([
      %w[_ _ _],
      %w[_ _ _],
      %w[_ _ _]
      ], @tic_tac_board.board)
  end

  def test_player_marked_a_position
    @tic_tac_board.mark_position(@player_with_x, [1,1])
    assert_equal([
      %w[X _ _],
      %w[_ _ _],
      %w[_ _ _]
      ], @tic_tac_board.board)
  end

  def test_player_marked_a_valid_position
    assert_equal true, @tic_tac_board.valid_position?([1,1])
  end

  def test_player_marked_invalid_position
    @tic_tac_board.mark_position(@player_with_x, [1,1])

    assert_equal false, @tic_tac_board.valid_position?([4,1])
    assert_equal false, @tic_tac_board.valid_position?([1,1]) # because i already marked this position
  end

  def test_next_player_to_make_a_move
    assert_equal @player_with_x, @tic_tac_board.next_player_to_make_a_move

    @tic_tac_board.mark_position(@player_with_x, [1,1])
    assert_equal @player_with_o, @tic_tac_board.next_player_to_make_a_move
  end

  def test_total_moves_for_x
    assert_equal 0, @tic_tac_board.total_moves_for_x

    @tic_tac_board.mark_position(@player_with_x, [1,1])
    assert_equal 1, @tic_tac_board.total_moves_for_x
  end

  def test_total_moves_for_o
    assert_equal 0, @tic_tac_board.total_moves_for_o

    @tic_tac_board.mark_position(@player_with_o, [1,1])
    assert_equal 1, @tic_tac_board.total_moves_for_o
  end
end