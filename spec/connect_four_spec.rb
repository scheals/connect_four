# frozen_string_literal: true

# rubocop: disable Layout/LineLength

require_relative '../lib/board'

# is a two-player connection board game, in which the players choose a color and
# then take turns dropping colored tokens into a seven-column, six-row vertically suspended grid.
# The pieces fall straight down, occupying the lowest available space within the column.
# The objective of the game is to be the first to form a horizontal, vertical, or diagonal line of four of one's own tokens.
describe Gameboard do
  describe '#initialize' do
    subject(:new_board) { described_class.new }
    it 'stores a 2D array representation of the board in @board' do
      board_array = Array.new(6) { Array.new(7) { "\u26F6" } }
      expect(new_board.instance_variable_get(:@board)).to eq(board_array)
    end
  end
end
# rubocop: enable Layout/LineLength
