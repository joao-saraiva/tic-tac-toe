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

  def winner_scenarios_by_char(char)
    {
      first_line_win: [
        ["#{char}", "#{char}", "#{char}"],
        ["_", "_", "_"],
        ["_", "_", "_"]
      ],
      second_line_win: [
        ["_", "_", "_"],
        ["#{char}", "#{char}", "#{char}"],
        ["_", "_", "_"]
      ],
      third_line_win: [
        ["_", "_", "_"],
        ["_", "_", "_"],
        ["#{char}", "#{char}", "#{char}"]
      ],
      first_column_win: [
        ["#{char}", "_", "_"],
        ["#{char}", "_", "_"],
        ["#{char}", "_", "_"]
      ],
      second_coumn_win: [
        ["_", "#{char}", "_"],
        ["_", "#{char}", "_"],
        ["_", "#{char}", "_"]
      ],
      third_coumn_win: [
        ["_", "_", "#{char}"],
        ["_", "_", "#{char}"],
        ["_", "_", "#{char}"]
      ],
      first_diagonally_win: [
        ["#{char}", "_", "_"],
        ["_", "#{char}", "_"],
        ["_", "_", "#{char}"]
      ],
      second_diagonally_win: [
        ["_", "_", "#{char}"],
        ["_", "#{char}", "_"],
        ["#{char}", "_", "_"]
      ]
    }
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

  def test_x_winner?
    assert_equal false, @tic_tac_board.x_winner?

    winner_scenarios_by_char("X").each do |key, value|
      @tic_tac_board.board = value
      assert_equal true, @tic_tac_board.x_winner?
    end
  end

  def test_o_winner?
    assert_equal false, @tic_tac_board.o_winner?

    winner_scenarios_by_char("O").each do |key, value|
      @tic_tac_board.board = value
      assert_equal true, @tic_tac_board.o_winner?
    end
  end

  def test_draw?
    assert_equal false, @tic_tac_board.draw?

    @tic_tac_board.board = [
      %w[X O X],
      %w[O X X],
      %w[O X O]
      ]

    assert_equal true, @tic_tac_board.draw?
  end

  def test_game_on_going
    assert_equal true, @tic_tac_board.on_going?

    @tic_tac_board.board = [
      %w[X O X],
      %w[O X X],
      %w[O X O]
      ]
    assert_equal false, @tic_tac_board.on_going?

    @tic_tac_board.board = [
      %w[X O X],
      %w[O X X],
      %w[O X _]
    ]
    assert_equal true, @tic_tac_board.on_going?

    @tic_tac_board.board = [
      %w[O O X],
      %w[O X X],
      %w[_ X X]
    ]

    assert_equal false, @tic_tac_board.on_going?
  end

  def test_any_empty_space
    assert_equal true, @tic_tac_board.any_empty_space?

    @tic_tac_board.board = [
      %w[X O X],
      %w[O X X],
      %w[O X O]
      ]

      assert_equal false, @tic_tac_board.any_empty_space?

    @tic_tac_board.board = [
      %w[X O X],
      %w[O X X],
      %w[O X _]
      ]

      assert_equal true, @tic_tac_board.any_empty_space?
  end
end