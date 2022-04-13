# frozen_string_literal: true

# rubocop: disable Layout/LineLength, Metrics/BlockLength

require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/gamedriver'

describe Board do
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
      subject(:board_tie) { described_class.new }
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

describe Player do
  subject(:new_player) { described_class.new('Peter', "\u26AA") }
  describe '#initialize' do
    it 'creates a player with a name' do
      expect(new_player.name).to be('Peter')
    end
    it 'creates a player with a token' do
      expect(new_player.token).to be("\u26AA")
    end
  end
end

describe GameDriver do
  describe '#create_player' do
    subject(:new_player) { described_class }
    it 'creates a player with a name and a token' do
      expect(new_player.create_player('Nadia', "\u26AB")).to have_attributes(name: 'Nadia', token: "\u26AB")
    end
  end

  describe '#create_board' do
    subject(:new_board) { described_class }
    it 'creates a suitable board' do
      expect(new_board.create_board).to respond_to(:show, :drop, :win?, :tie?, :valid_column?)
    end
  end
end

describe Game do
  describe '#make_move' do
    subject(:game_move) { described_class.new(Player.new('Shohreh', "\u26AB"), Player.new('Setareh', "\u26AA"), Board.new) }
    it 'places one token' do
      column = 1
      expect { game_move.make_move(column) }.to change { game_move.board.send(:first_row).first }
    end
  end

  describe '#switch_players' do
    subject(:game_switch) { described_class.new(player1, player2, Board.new) }
    let(:player1) { Player.new('Shohreh', "\u26AB") }
    let(:player2) { Player.new('Setareh', "\u26AA") }
    before do
      game_switch.instance_variable_set(:@current_player, player2)
    end
    it 'changes current_player to the other player' do
      expect { game_switch.switch_players }.to change { game_switch.current_player }
    end
  end

  describe '#which_column' do
    context 'when input is valid' do
      subject(:valid_column) { described_class.new(player1, player2, Board.new) }
      let(:player1) { Player.new('Jahan', "\u26AB") }
      let(:player2) { Player.new('Behrouz', "\u26AA") }
      before do
        allow(valid_column).to receive(:gets).and_return('3')
        allow(valid_column).to receive(:puts)
      end
      it 'returns a number' do
        valid_input = 3
        expect(valid_column.which_column).to be(valid_input)
      end
    end
    context 'when input is invalid twice and then valid' do
      subject(:input_thrice) { described_class.new(player1, player2, Board.new) }
      let(:player1) { Player.new('Farid', "\u26AB") }
      let(:player2) { Player.new('Aftab', "\u26AA") }
      before do
        allow(input_thrice).to receive(:gets).and_return('11', '0', '7')
        allow(input_thrice).to receive(:puts).exactly(5).times
      end
      it 'prints an error to the console twice and ends loop' do
        error_message = 'Column not found. Proper columns start at 1 and end at 7.'
        expect(input_thrice).to receive(:puts).with(error_message).twice
        input_thrice.which_column
      end
    end
  end

  describe '#game_loop' do
    context 'when the game is won' do
      subject(:game_won) { described_class.new(player1, player2, board) }
      let(:player1) { Player.new('Anahita', "\u26AB") }
      let(:player2) { Player.new('Farahnaz', "\u26AA") }
      let(:board) { Board.new }
      before do
        allow(board).to receive(:win?).and_return(true).once
        allow(board).to receive(:show)
        allow(game_won).to receive(:puts)
        allow(game_won).to receive(:make_move)
        allow(game_won).to receive(:which_column)
      end
      it 'stops and displays a message' do
        congratulations = "You did it #{game_won.current_player.name}! You won!"
        expect(game_won).to receive(:puts).with(congratulations).once
        game_won.game_loop
      end
    end
    context 'when the game is tied' do
      subject(:game_tied) { described_class.new(player1, player2, board) }
      let(:player1) { Player.new('Anahita', "\u26AB") }
      let(:player2) { Player.new('Farahnaz', "\u26AA") }
      let(:board) { Board.new }
      before do
        allow(board).to receive(:tie?).and_return(true).once
        allow(board).to receive(:show)
        allow(game_tied).to receive(:puts)
        allow(game_tied).to receive(:make_move)
        allow(game_tied).to receive(:which_column)
      end
      it 'stops and displays a message' do
        message = 'That was a long one! You have tied.'
        expect(game_tied).to receive(:puts).with(message).once
        game_tied.game_loop
      end
    end
  end
end
# rubocop: enable Layout/LineLength, Metrics/BlockLength
