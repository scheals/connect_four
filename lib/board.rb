# frozen_string_literal: true

# This is a class that handles a Connect Four gameboard with its rules.
class Gameboard
  def initialize
    @board = Array.new(6) { Array.new(7) { "\u26F6" } }
  end
end
