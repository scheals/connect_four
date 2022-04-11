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
      board_array = Array.new(6) { Array.new(7) { '  ' } }
      expect(new_board.instance_variable_get(:@board)).to eq(board_array)
    end
  end

  describe '#show' do
    context 'when a new board is created' do
      subject(:starter_board) { described_class.new }
      it 'outputs a legible representation with no inputs' do
        representiation = "\n    " \
        '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          '||    ||    ||    ||    ||    ||    ||    ||' \
          "\n    " \
          " \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C \u268C" \
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
    context 'when column is full' do
      subject(:drop_onto_full) { described_class.new }
      before do
        drop_onto_full.send(:first_row)[0] = "\u26AA"
        drop_onto_full.send(:second_row)[0] = "\u26AB"
        drop_onto_full.send(:third_row)[0] = "\u26AB"
        drop_onto_full.send(:fourth_row)[0] = "\u26AA"
        drop_onto_full.send(:fifth_row)[0] = "\u26AA"
        drop_onto_full.send(:sixth_row)[0] = "\u26AB"
      end
      it 'returns nil' do
        black_token = "\u26AA"
        column = 1
        expect(drop_onto_full.drop(black_token, column)).to be(nil)
      end
    end
  end

  describe '#win?' do
    context 'when there are four same colour tokens in a row' do
      subject(:row_win) { described_class.new }
      before do
        white_token = "\u26AB"
        row_win.drop(white_token, 1)
        row_win.drop(white_token, 2)
        row_win.drop(white_token, 3)
        row_win.drop(white_token, 4)
      end
      it 'returns true' do
        expect(row_win.win?).to be(true)
      end
      after do
        row_win.show
      end
    end
    context 'when there are four same colour tokens in a column' do
      subject(:column_win) { described_class.new }
      before do
        black_token = "\u26AA"
        column_win.drop(black_token, 1)
        column_win.drop(black_token, 1)
        column_win.drop(black_token, 1)
        column_win.drop(black_token, 1)
      end
      it 'returns true' do
        expect(column_win.win?).to be(true)
      end
      after do
        column_win.show
      end
    end
    context 'when there are four same colour tokens in a diagonal' do
      subject(:diagonal_win) { described_class.new }
      before do
        white_token = "\u26AB"
        black_token = "\u26AA"
        diagonal_win.drop(white_token, 2)
        2.times { diagonal_win.drop(white_token, 3) }
        3.times { diagonal_win.drop(white_token, 4) }
        diagonal_win.drop(black_token, 1)
        diagonal_win.drop(black_token, 2)
        diagonal_win.drop(black_token, 3)
        diagonal_win.drop(black_token, 4)
      end
      it 'returns true' do
        expect(diagonal_win.win?).to be(true)
      end
      after do
        diagonal_win.show
      end
    end
  end

  describe '#tie?' do
    context 'when every single space is filled' do
      subject(:board_tie) {described_class.new }
      before do
        white_token = "\u26AB"
        black_token = "\u26AA"
        3.times { board_tie.drop(white_token, 1) }
        3.times { board_tie.drop(black_token, 1) }
        3.times { board_tie.drop(black_token, 2) }
        3.times { board_tie.drop(white_token, 2) }
        3.times { board_tie.drop(white_token, 3) }
        3.times { board_tie.drop(black_token, 3) }
        3.times { board_tie.drop(black_token, 4) }
        3.times { board_tie.drop(white_token, 4) }
        3.times { board_tie.drop(white_token, 5) }
        3.times { board_tie.drop(black_token, 5) }
        3.times { board_tie.drop(black_token, 6) }
        3.times { board_tie.drop(white_token, 6) }
        3.times { board_tie.drop(white_token, 7) }
        3.times { board_tie.drop(black_token, 7) }
      end
      it 'returns true' do
        expect(board_tie.tie?).to be(true)
      end
      after do
        board_tie.show
      end
    end
  end
end
# rubocop: enable Layout/LineLength, Metrics/BlockLength
