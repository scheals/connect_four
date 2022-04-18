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

  def game_loop
    loop do
      puts 'This is how the board looks like:'
      board.show
      make_move(which_column)
      break if game_over?

      switch_players
    end
    puts "Thanks for playing, #{first_player.name} and #{second_player.name}!"
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
    puts "#{current_player.name} #{current_player.token}, which column do you want to drop token into?"
    column = gets.chomp.to_i
    return column if board.valid_column?(column)

    puts 'Column not found or full. Proper columns start at 1 and end at 7.'
    which_column
  end

  def game_over?
    if board.win?
      win
      true
    elsif board.tie?
      tie
      true
    else
      false
    end
  end

  private

  def win
    board.show
    puts "You did it #{current_player.name}! You won!"
  end

  def tie
    board.show
    puts 'That was a long one! You have tied.'
  end
end
