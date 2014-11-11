require_relative '../lib/board'

describe Board do
  let(:board3x3){ Board.new([1,2,3,4,5,6,7,8,9]) }
  let(:board4x4){ Board.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]) }
 
  describe '#shift_move_from_available_to_played' do
    context '3x3 board' do
      it 'returns a board with Player move removed' do 
        player_move = 1
        expect(board3x3.shift_move_from_available_to_played(player_move)).to eq([1])
      end

      it 'adds player move to all_moves_played class attribute' do
        player_move = 1
        board3x3.shift_move_from_available_to_played(player_move)
        expect(board3x3.all_moves_played).to eq([1])
      end
    end

    context '4x4 board' do
      it 'adds Player move to all_moves_played class attribute' do
        player_move = 1
        board4x4.shift_move_from_available_to_played(player_move)
        expect(board4x4.all_moves_played).to eq([1])
      end

      it 'deletes player move from available_spaces attribute' do
        player_move = 1
        board4x4.shift_move_from_available_to_played(player_move)
        expect(board4x4.available_spaces).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
      end

    end
  end

  describe '#add_move_to_players_move' do
    context 'Board size agnostic' do
      it 'adds move to player moves played' do
        player_move = 1
        board3x3.add_move_to_players_moves(player_move, board3x3.player1_already_played)
        expect(board3x3.player1_already_played).to eq([1])
      end
    end
  end

  describe '#apply_move_to_board' do
    context '3x3 board' do
      it 'adds move to player played and shifts move from available to played' do
        player_move = 1
        board3x3.apply_move_to_board(player_move, board3x3.player1_already_played)
        expect(board3x3.all_moves_played).to eq([1])
        expect(board3x3.player1_already_played).to eq([1])
        expect(board3x3.available_spaces).to eq([2,3,4,5,6,7,8,9])
      end
    end
    
    context '4x4 board' do
      it 'adds move to player played and shifts move from available to played' do
        player_move = 1
        board4x4.apply_move_to_board(player_move, board4x4.player1_already_played)
        expect(board4x4.all_moves_played).to eq([1])
        expect(board4x4.player1_already_played).to eq([1])
        expect(board4x4.available_spaces).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
      end
    end
  end

  describe '#reset_board' do
    context '3x3 board' do
      it 'resets all of the self Board attributes to match the attributes of a moves_to_be_reset passed in as an argument' do
        available_moves_to_reset = [1,2]
        all_moves_played_to_reset = [1,2,3,4,5,6,7,8,9]
        player1_moves = [1,3,4,5,6]
        player2_moves = [2,7,8,9]
        remaining_moves = []
        copy_board = Board.new(remaining_moves, all_moves_played_to_reset, player1_moves, player2_moves)
        copy_board.reset_board(available_moves_to_reset)
        expect(copy_board.all_moves_played).to eq([3,4,5,6,7,8,9])
        expect(copy_board.available_spaces).to eq([1,2])
        expect(copy_board.player1_already_played).to eq([3,4,5,6])
        expect(copy_board.player2_already_played).to eq([7,8,9])
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
