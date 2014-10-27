require_relative '../lib/board'

describe Board do
  class Dummy
  end

  before(:all) do
    @board = Dummy.new
    @board.extend Board
  end

  let(:winning_3board_combos) { [[1,2,3],[4,5,6],[7,8,9],[1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]] }
  let(:winning_4board_combos) { [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16], [1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16],[1,6,11,16], [4,7,10,13]] }
  let(:board_size3) { 3 }
  let(:board_size4) { 4 }

  describe '#winner?' do
    context 'default 3x3 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [1,2,3]
        expect(@board.winner?(player_moves, winning_3board_combos )).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [4,2,3]
        expect(@board.winner?(player_moves, winning_3board_combos)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [1,4,2,3]
        expect(@board.winner?(player_moves, winning_3board_combos)).to eq(true)
      end

      it 'returns false if player moves does not include winning comb among other moves' do 
        player_moves = [1,3,7,9]
        expect(@board.winner?(player_moves,winning_3board_combos )).to eq(false)
      end
    end

    context '4x4 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [1,2,3,4]
        expect(@board.winner?(player_moves, winning_4board_combos, board_size4)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [4,2,3,9]
        expect(@board.winner?(player_moves, winning_4board_combos, board_size4)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [1,2,3,8,10,4]
        expect(@board.winner?(player_moves,winning_4board_combos, board_size4)).to eq(true)
      end
      
      it 'returns false if player moves does not include winning combo among other moves' do 
        player_moves = [1,8,9,13,16]
        expect(@board.winner?(player_moves, winning_4board_combos, board_size4)).to eq(false)
      end
    end
  end

  describe '#apply_move_to_board' do
    context '3x3 board' do
      it 'returns a board with Player move removed' do 
        original_board = [1,2,3,4,5,6,7,8,9]
        expect(@board.apply_move_to_board(original_board, 1)).to eq([2,3,4,5,6,7,8,9])
      end
    end

    context '4x4 board' do
      it 'returns a board with Player move removed' do
        original_board = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
        expect(@board.apply_move_to_board(original_board, 1)).to eq([2,3,4,5,6,7,8,9, 10,11,12,13,14,15,16])
        end
    end
  end

  describe '#all_moves_played'  do
    context 'Board size agnostic' do
      it 'returns all the move spaces which have already been played by either player' do
        current_board = [1,2]
        original_board = [1,2,3,4] 
        expect(@board.all_moves_played(current_board, original_board)).to eq([3,4])
      end
    end
  end

  describe '#valid_move?' do
    context 'Board size agnostic' do
      it 'returns false if move is not included in current board state' do
        current_board = [1,2,3]
        expect(@board.valid_move?(4, current_board)).to eq(false)
      end

      it 'returns true if move is included in current board state' do
        current_board = [1,2,3]
        expect(@board.valid_move?(3, current_board)).to eq(true)
      end
    end
  end


end
