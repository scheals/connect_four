# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# This is a class that handles a Connect Four game.
class Game
  def initialize(first_player, second_player, board)
    @first_player = first_player
    @second_player = second_player
    @board = board
  end
end
