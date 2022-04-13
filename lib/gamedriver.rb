# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'player'

# This class handles running the game.
class GameDriver
  def self.setup
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
end
