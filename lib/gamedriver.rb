# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'player'

# This class handles running the game.
class GameDriver
  def self.setup
    puts instructions
    puts "What's the name of the first player?"
    first_name = gets.chomp
    puts "What's the name of the second player?"
    second_name = gets.chomp
    puts "Created game with #{first_name} as \u26AB and #{second_name} as \u26AA."
    Game.new(create_player(first_name, "\u26AB"), create_player(second_name, "\u26AA"), create_board)
  end

  def self.create_player(name, token)
    Player.new(name, token)
  end

  def self.create_board
    Board.new
  end

  def self.instructions
    puts <<-HEREDOC
    Welcome to Connect Four!
    This is a two player game where the objective is to have four tokens of your colour
    in one of these arrangements:
    - a row, e.g.:

    \u26AB \u26AB \u26AB \u26AB

    - a column, e.g.:

    \u26AA
    \u26AA
    \u26AA
    \u26AA

    - a diagonal, e.g.:

    \u26AB
    \u26AB
    \u26AB
    \u26AB

    You achieve this by dropping tokens from the top of the column to the first free space on its way down.
    If all spaces are occupied but no one has won it is a tie.
    Good luck and enjoy!

    HEREDOC
  end
end
