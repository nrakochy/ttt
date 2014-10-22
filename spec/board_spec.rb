require_relative '../lib/board'

describe Board do

    let(:three_board)[Board(winner => [[1,2,3],[4,5,6],[7,8,9],[1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]], board_spaces = 9)]}
    let(:four_board) {Board.new([[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16], [1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16],[1,6,11,16], [4,7,10,13]], 16)}

  describe '#winner?' do
    it 'returns true if player moves has a winning combination' do 
      player_moves = [1,2,3]
      three_board = instance_double('three_board', winner: [[1,2,3],[4,5,6],[7,8,9],[1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]])
      expect(three_board.winner?(player_moves)).to eq(true)
    end

    it 'returns false if player moves does not have a winning combination' do 
      player_moves = [4,2,3]
      expect(Board.new.winner?(player_moves)).to eq(false)
    end

    it 'returns true if player moves includes winning combo among other moves' do 
      player_moves = [1,4,2,3]
      expect(Board.new.winner?(player_moves)).to eq(true)
    end

    it 'returns false if player moves does not include winning comb among other moves' do 
      player_moves = [1,3,7,9]
      expect(Board.new.winner?(player_moves)).to eq(false)
    end
  end

  describe '#apply_move_to_board' do
    it 'returns a board with Player move removed' do 
      original_board = [1,2,3,4,5,6,7,8,9]
      expect(Board.new.apply_move_to_board(original_board, 1)).to eq([2,3,4,5,6,7,8,9])
    end
  end

  describe '#all_moves_played'  do
    it 'returns all the move spaces which have already been played by either player' do
      current_board = [1,2]
      original_board = [1,2,3,4] 
      expect(Board.new.all_moves_played(current_board, original_board)).to eq([3,4])
    end
  end

  describe '#valid_move?' do
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
