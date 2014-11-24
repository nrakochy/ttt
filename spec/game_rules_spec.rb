require_relative '../lib/game_rules'
require_relative '../lib/board'

describe GameRules do

  let(:board3x3){ Board.new }
  let(:board4x4){ Board.new(4) }
  let(:winning_3board_combos){ [[0,1,2],[3,4,5],[6,7,8],[0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]] }
  let(:winning_4board_combos){ [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15],[0,5,10,15], [3,6,9,12]] }
  let(:game_rules3board){ GameRules.new(board3x3, winning_3board_combos)}
  let(:game_rules4board){ GameRules.new(board4x4, winning_4board_combos)}

  describe '#winner?' do
    context 'default 3x3 board' do
      it 'returns true if player moves has a winning combination' do
        player_moves = [0,1,2]
        expect(game_rules3board.winner?(player_moves)).to eq(true)
      end

      it 'returns false on a new board' do
        player_moves = [1,2,3]
        expect(game_rules3board.winner?(player_moves)).to eq(false)
      end
    end

    context '4x4 board' do
      it 'returns true if player moves has a winning combination' do
        player_moves = [0,1,2,3]
        expect(game_rules4board.winner?(player_moves)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do
        player_moves = [4,2,3,9]
        expect(game_rules4board.winner?(player_moves)).to eq(false)
      end
    end
  end

  describe '#find_winning_columns' do
      it 'identifies the columns with winning combinations for 3-in-a-row by default' do
        expect(game_rules3board.find_winning_columns).to eq([[0,3,6], [1,4,7], [2,5,8]])
      end

    it 'identifies the columns with winning combinations for 4-in-a-row' do
      expect(game_rules4board.find_winning_columns).to eq([[0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15]])
    end
  end

  describe '.find_winning_rows' do
    it 'identifies the rows with winning combinations for 3-in-a-row by default' do
      expect(game_rules3board.find_winning_rows).to eq([[0,1,2],[3,4,5],[6,7,8]])
    end

    it 'identifies the rows with winning combinations for 4-in-a-row' do
      expect(game_rules4board.find_winning_rows).to eq([[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15]])
    end
  end

  describe '.find_winning_left_diagonal' do
    it 'identifies the top left diagonal winning combination for 3-in-a-row by default' do
      expect(game_rules3board.find_winning_left_diagonal).to eq([0,4,8])
    end

    it 'identifies the top left diagonal winning combination for 4-in-a-row' do
      expect(game_rules4board.find_winning_left_diagonal).to eq([0,5,10,15])
    end
  end

  describe '.find_winning_right_diagonal' do
    it 'identifies the top right diagonal winning combination for 3-in-a-row by default' do
      expect(game_rules3board.find_winning_right_diagonal).to eq([2,4,6])
    end

    it 'identifies the top right diagonal winning combination for 4-in-a-row' do
      expect(game_rules4board.find_winning_right_diagonal).to eq([3,6,9,12])
    end
  end

  describe 'winning move finder methods' do
    describe '#winner?' do
      context 'default 3x3 board' do
        it 'returns true if player moves has a winning combination' do
          player_moves = [0,1,2]
          expect(game_rules3board.winner?(player_moves)).to eq(true)
        end

        it 'returns false on a new board' do
          player_moves = [1,2,3]
          expect(game_rules3board.winner?(player_moves)).to eq(false)
        end
      end

      context '4x4 board' do
        it 'returns true if player moves has a winning combination' do
          player_moves = [0,1,2,3]
          expect(game_rules4board.winner?(player_moves)).to eq(true)
        end

        it 'returns false if player moves does not have a winning combination' do
          player_moves = [4,2,3,9]
          expect(game_rules4board.winner?(player_moves)).to eq(false)
        end
      end
    end

    describe 'tie?' do
      it 'returns true if move_count is the same as board_size-- no more available moves' do
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

def make_full_3board(board)
  board.game_board = (
    ["X", "O", "X",
     "O", "O", "X",
     "X", "X", "O"])
  self
=begin
X | O | X
O | O | X
X | X | O
=end
end

def make_full_4board(board)
  board.game_board = (
    ["X", "O", "X", "O",
     "O", "O", "X", "X",
     "X", "X", "O", "O",
     "X", "O", "X", "O"])
  self
=begin
X | O | X | O
O | O | X | X
X | X | O | O
X | O | X | O
=end
end


