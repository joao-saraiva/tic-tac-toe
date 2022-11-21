# frozen_string_literal: true

# This is class is the core of the game, it may be able to define winner,
# choose the next player and validate moves.
class TicTacBoard
  attr_accessor :board, :players
  WINNER_SCNEARIOS = [
    #Row Scenarios
    [[0,0], [0,1], [0,2]],
    [[1,0], [1,1], [1,2]],
    [[2,0], [2,1], [2,2]],

    #Column Scenarios
    [[0,0], [1,0], [2,0]],
    [[0,1], [1,1], [2,1]],
    [[0,2], [1,2], [2,2]],

    #Diagonally Scenarios
    [[0,0], [1,1], [2,2]],
    [[0,2], [1,1], [2,0]],
  ]

  def initialize(players)
    raise "Need to be 2 players" if players.compact.size != 2

    @players = players.sort_by{ |p| p.first_to_play? ? 0 : 1}
    start_board
  end

  def mark_position(player, coordinates)
    set_row_and_column(coordinates)
    @board[@row][@column] = player.marker
  end

  def valid_position?(coordinates)
    set_row_and_column(coordinates)
    return false if row_out_of_bounds? || column_out_of_bounds?

    @board[@row][@column] == "_"
  end

  def next_player_to_make_a_move
    return player_with_x if empty_board? 

    total_moves_for_x >= total_moves_for_o ? player_with_o : player_with_x
  end

  def empty_board?
    @board.all?{ |row| row.all?("_") }
  end

  def player_with_x
    players.detect{ |p| p.marker == "X" }
  end

  def player_with_o
    players.detect{ |p| p.marker == "O" }
  end

  def total_moves_for_x
    total_moves_for_char("X")
  end

  def total_moves_for_o
    total_moves_for_char("O")
  end

  def start_board
    @board = [
      %w[_ _ _],
      %w[_ _ _],
      %w[_ _ _]
    ]
  end

  alias_method :reset_board, :start_board

  def x_winner?
    winner_by_char("X")
  end

  def o_winner?
    winner_by_char("O")
  end

  def draw?
    !empty_board? && !x_winner? && !o_winner?
  end

  private

  def set_row_and_column(coordinates)
    @row = coordinates.first - 1
    @column = coordinates.last - 1
  end

  def row_out_of_bounds?
    @row > 2 || @row < 0
  end

  def column_out_of_bounds?
    @column > 2 || @column < 0
  end

  def total_moves_for_char(char)
    total_moves = 0

    @board.each do |row|
      total_moves += row.select{ |column| column == char }.size
    end

    total_moves
  end

  def winner_by_char(char)
    WINNER_SCNEARIOS.each do |winner_scenario|
      x_count = 0
      winner_scenario.each do |coordinates|
        row = coordinates.first
        column = coordinates.last
        x_count += 1 if @board[row][column] == char
      end

      return true if x_count == 3
    end

    false
  end
end