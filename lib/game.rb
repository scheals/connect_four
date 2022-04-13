# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# This is a class that handles a Connect Four game.
class Game
  attr_reader :current_player, :board

  def initialize(first_player, second_player, board)
    @first_player = first_player
    @second_player = second_player
    @board = board
    @current_player = first_player
  end

  def make_move(column)
    board.drop(current_player.token, column)
  end
end
