require_relative '../lib/board'

describe Board do
 
  describe '#apply_move_to_board' do
    context '3x3 board' do
      it 'returns a board with Player move removed' do 
        original_board = [1,2,3,4,5,6,7,8,9]
        player_move = 1
        expect(Board.new.apply_move_to_board(original_board, player_move)).to eq([2,3,4,5,6,7,8,9])
      end
    end

    context '4x4 board' do
      it 'returns a board with Player move removed' do
        original_board = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
        player_move = 1
        expect(Board.new.apply_move_to_board(original_board, player_move)).to eq([2,3,4,5,6,7,8,9, 10,11,12,13,14,15,16])
        end
    end
  end

  describe '#all_moves_played'  do
    context 'Board size agnostic' do
      it 'returns all the move spaces which have already been played by either player' do
        current_board = [1,2]
        original_board = [1,2,3,4] 
        expect(Board.new.all_moves_played(current_board, original_board)).to eq([3,4])
      end
    end
  end

  describe '#valid_move?' do
    context 'Board size agnostic' do
      it 'returns false if move is not included in current board state' do
        current_board = [1,2,3]
        expect(Board.new.valid_move?(4, current_board)).to eq(false)
      end

      it 'returns true if move is included in current board state' do
        current_board = [1,2,3]
        expect(Board.new.valid_move?(3, current_board)).to eq(true)
      end
    end
  end


end
