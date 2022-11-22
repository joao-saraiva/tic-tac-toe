require_relative "player"
require_relative "tic_tac_board"

player_1_marker = nil
coordinates = nil

while player_1_marker != "X" && player_1_marker != "O"
  puts "Select Your Marker (X OR O)"
  player_1_marker = gets.chomp.upcase
end

player1 = Player.new(player_1_marker)
player2 = Player.new(player1.opposite_marker)

tic_tac_board = TicTacBoard.new([player1, player2])

while tic_tac_board.on_going?
  system ("clear")
  puts tic_tac_board.draw_board

  puts "Selecy your coordinates Player(#{tic_tac_board.next_player_to_make_a_move.marker}) (Row, Column)"
  coordinates = gets.chomp
  formated_coordinates = coordinates.split(",").map{ |c| c.strip.to_i }

  next unless formated_coordinates.all?{ |f| f.is_a? Integer}

  if tic_tac_board.valid_position?(formated_coordinates)
    tic_tac_board.mark_position(tic_tac_board.next_player_to_make_a_move, formated_coordinates)
  end

  unless tic_tac_board.on_going?
    system ("clear")
    puts tic_tac_board.draw_board

    puts "\nX is the winner" if tic_tac_board.x_winner?
    puts "\nO is the winner" if tic_tac_board.o_winner?
    puts "\nIt was a draw" if tic_tac_board.draw?

    puts "Do you want to play it again ? (1 - yes, 2 - no)"
    play_again = gets.chomp.upcase

    tic_tac_board.reset_board if play_again == "1"
  end
end