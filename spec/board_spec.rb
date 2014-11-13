require_relative '../lib/board'
require_relative '../lib/game_rules'

describe Board do
  let(:rules) { GameRules.new }
  let(:board3x3){ Board.new(rules).new_board }
  let(:board4x4){ Board.new(rules, 16).new_board }

 
  describe '#new_board' do
    context '3x3 board' do
      it 'creates a 3x3 board array with new spaces by default' do
        expect(board3x3.game_board).to eq((1..9).to_a)
      end
    end

    context '4x4 board' do
      it 'creates a 4x4 board array with 16 spaces' do
        expect(board4x4.game_board).to eq((1..16).to_a)
      end
    end
  end

  describe '#apply_move_to_board' do
    context 'Board size agnostic' do
      it 'replaces existing board piece with new move piece' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        expect(board3x3.game_board).to eq(['X'] + (2..9).to_a)
      end
    end
  end

  describe '#valid_move?' do
    context 'Board size agnostic' do
      it 'returns true if game board includes move' do
        move = 1
        expect(board3x3.valid_move?(move)).to eq(true)
      end

      it 'returns false if game board does not include move' do
        move = 10
        expect(board3x3.valid_move?(move)).to eq(false)
      end
    end
  end

  describe '#undo_move' do
    context 'Board size agnostic' do
      it 'removes a move from the board and replaces it with the representative number of its space' do
        board3x3.test_method_game_board(['X', 'O'] + (3..9).to_a)
        board3x3.undo_move(2)
        expect(board3x3.game_board).to eq(['X'] + (2..9).to_a)
      end
    end
  end

  describe '#valid_move?' do
    context 'Board size agnostic' do
      it 'returns false if move is not included in current board state' do
      end

      it 'returns true if move is included in current board state' do
      end
    end
  end


end
