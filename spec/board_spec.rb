require_relative '../lib/board'

describe Board do
  let(:board3x3){ Board.new }
  let(:board4x4){ Board.new(4) }

  describe '#initialize' do
    context '3x3 board' do
      it 'creates a 3x3 game_board array [1..9] by default' do
        expect(board3x3.game_board).to eq((1..9).to_a)
      end

      it 'has 9 open spaces to begin the game' do
        expect(board3x3.open_spaces.count).to eq(9)
      end

      it 'has 0 move count to begin the game' do
        expect(board3x3.move_count).to eq(0)
      end
    end

    context '4x4 board' do
      it 'creates a 4x4 board array with 16 spaces' do
        expect(board4x4.game_board).to eq((1..16).to_a)
      end

      it 'has 16 open spaces to begin the game' do
        expect(board4x4.open_spaces.count).to eq(16)
      end

      it 'has 0 move count to begin the game' do
        expect(board4x4.move_count).to eq(0)
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

      it 'removes the played board space from @open_spaces' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        expect(board3x3.open_spaces).to eq((2..9).to_a)
      end


      it 'increments @move_count when a move is placed on the board' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        expect(board3x3.move_count).to eq(1)
      end
    end
  end

  describe '#valid_move?' do
    context 'Board size agnostic' do
      it 'returns true if the open_spaces include move' do
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
      it 'adds a move number back into the @game_board' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        board3x3.undo_move(board_space)
        expect(board3x3.game_board).to eq((1..9).to_a)
      end

      it 'adds a move number back into the @open_spaces' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        board3x3.undo_move(board_space)
        expect(board3x3.open_spaces).to eq((1..9).to_a)
      end

      it 'decreases @move_count by 1' do
        player_symbol = 'X'
        board_space = 1
        board3x3.apply_move_to_board(board_space, player_symbol)
        board3x3.undo_move(board_space)
        expect(board3x3.move_count).to eq(0)
      end
    end
  end
end

