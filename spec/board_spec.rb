require_relative '../lib/board'
require_relative '../lib/game_rules'

describe Board do
  let(:rules) { GameRules.new }
  let(:board3x3){ Board.new(rules).new_board }
  let(:board4x4){ Board.new(rules, 16).new_board }
  let(:full3x3board){ Board.new(rules, 9, ['X', 'O', 'O', 'X', 'X', 'X', 'O', 'O', 'X']) }

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

  describe 'winning move finder methods' do
    context '3x3 board' do
      describe 'winner?' do
        it 'returns true if a given combination of moves is one of the winning combinations' do
          player_combo = [0,1,2]
          expect(full3x3board.winner?(player_combo)).to eq(true)
        end

        it 'returns false is a given combination of moves is not one of the winning combinations' do
          player_combo = [1,2,3]
          expect(full3x3board.winner?(player_combo)).to eq(false)
        end
      end

      describe 'tie?' do
        it 'returns true if move_count is the same as board_size' do
          expect(full3x3board.tie?).to eq(true)
        end

        it 'returns false if there are still open moves on the board' do
          expect(board3x3.tie?).to eq(false)
        end
      end

      describe '#check_for_win' do
        it 'returns false if number of moves played by a player is less than 3, the minimum number needed for a win' do
          expect(board3x3.check_for_win?(board3x3.player1_symbol)).to eq(false)
        end

        it 'returns false if moves played by a player does not include a winning combination, irrspective of moves_played order' do
          expect(full3x3board.check_for_win?(full3x3board.player2_symbol)).to eq(false)
        end

        it 'returns true if moves played by a player includes a winning combination, irrespective of moves_played order' do
          expect(full3x3board.check_for_win?(full3x3board.player1_symbol)).to eq(true)
        end
      end


    end
  end



end
