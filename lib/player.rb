# frozen_string_literal: true

# This class is an abstratction of a tic-tac-toe player
# it contains information and validations to create a regular player
class Player
  attr_accessor :marker

  def initialize(marker)
    @marker = marker.upcase
    raise 'Marker should be X or O' unless valid_marker?
  end

  def first_to_play?
    @marker == 'X'
  end

  def valid_marker?
    @marker == 'X' || @marker == 'O'
  end

  def opposite_marker
    return 'O' if @marker == 'X'
    return 'X' if @marker == 'O'
  end
end
