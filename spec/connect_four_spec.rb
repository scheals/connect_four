# frozen_string_literal: true

# rubocop: disable Layout/LineLength, Metrics/BlockLength

require_relative '../lib/board'

# is a two-player connection board game, in which the players choose a color and
# then take turns dropping colored tokens into a seven-columnstarter_board., six-row vertically suspended grid.
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

  describe '#show' do
    context 'when a new board is created' do
      subject(:starter_board) { described_class.new }
      it 'outputs a legible representation with no inputs' do
        representiation = "\n    " \
        "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "|| \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 || \u26F6 ||" \
          "\n    " \
          "\u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C" \
          "\n\n"
        expect(starter_board).to receive(:puts).with(representiation)
        starter_board.show
      end
    end
  end

  describe '#drop_token' do
    context 'when column is empty' do
      subject(:drop_into_empty) { described_class.new }
      it 'drops to the bottom of a column' do
        white_token = "\u26AB"
        column = 1
        expect { drop_into_empty.drop(white_token, column) }.to change { drop_into_empty.send(:first_row)[0] }
      end
      after do
        drop_into_empty.show
      end
    end
    context 'when column has free space on top of tokens' do
      subject(:drop_onto_tokens) { described_class.new }
      before do
        drop_onto_tokens.send(:first_row)[0] = "\u26AA"
        drop_onto_tokens.send(:second_row)[0] = "\u26AB"
      end
      it 'drops to the topmost non-occupied space' do
        black_token = "\u26AA"
        column = 1
        expect { drop_onto_tokens.drop(black_token, column) }.to change { drop_onto_tokens.send(:third_row)[0] }
      end
      after do
        drop_onto_tokens.show
      end
    end
  end
end
# rubocop: enable Layout/LineLength, Metrics/BlockLength
