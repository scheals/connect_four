# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# This is a class that handles a Connect Four game.
class Game
  attr_reader :current_player, :board, :first_player, :second_player

  def initialize(first_player, second_player, board)
    @first_player = first_player
    @second_player = second_player
    @board = board
    @current_player = first_player
  end

  def make_move(column)
    board.drop(current_player.token, column)
  end

  def switch_players
    @current_player = if current_player == first_player
                        second_player
                      else
                        first_player
                      end
  end

  def which_column
    column = gets.chomp.to_i
    return column if (1..7).include?(column)

    puts 'Column not found. Proper columns start at 1 and end at 7.'
    which_column
  end
end
