# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/player'

class PlayerTest < MiniTest::Test
  def setup
    @player_with_x = Player.new('X')
    @player_with_o = Player.new('O')
  end

  def test_player_is_the_first_to_play
    assert_equal true, @player_with_x.first_to_play?
  end

  def test_player_is_not_the_first_to_play
    assert_equal false, @player_with_o.first_to_play?
  end

  def test_player_had_a_valid_marker
    assert_equal true, @player_with_x.valid_marker?
    assert_equal true, @player_with_o.valid_marker?
  end

  def test_player_cant_be_initialized_with_invalid_marker
    assert_raises(StandardError, 'Marker should be X or O') { Player.new('a') }
  end

  def test_player_opposite_marker
    assert_equal 'X', @player_with_o.opposite_marker
    assert_equal 'O', @player_with_x.opposite_marker
  end
end
