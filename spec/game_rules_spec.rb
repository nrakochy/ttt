require_relative '../lib/game_rules'
require_relative '../lib/board'

describe GameRules do

  let(:board3x3){ Board.new }
  let(:board4x4){ Board.new(4) }
  let(:full_3x3board_tie){ make_full_3board_tie(board3x3) }
  let(:full_3x3board_winner){ make_full_3board_winner(board3x3) }
  let(:winning_3board_combos){ [[0,1,2],[3,4,5],[6,7,8],[0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]] }
  let(:winning_4board_combos){ [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15],[0,5,10,15], [3,6,9,12]] }
  let(:game_rules_3board_empty){ GameRules.new(board3x3, winning_3board_combos) }
  let(:game_rules_3board_with_tie){ GameRules.new(full_3x3board_tie, winning_3board_combos )}
  let(:game_rules_3board_with_winner){ GameRules.new(full_3x3board_winner, winning_3board_combos )}
  let(:game_rules_4board_empty){ GameRules.new(board4x4, winning_4board_combos) }

  describe '#winner?' do
    context 'default 3x3 board' do
      it 'returns true if player moves has a winning combination' do
        player_moves = [0,1,2]
        expect(game_rules_3board_empty.winner?(player_moves)).to eq(true)
      end

      it 'returns false on a new board' do
        player_moves = [1,2,3]
        expect(game_rules_3board_empty.winner?(player_moves)).to eq(false)
      end
    end

    context '4x4 board' do
      it 'returns true if player moves has a winning combination' do
        player_moves = [0,1,2,3]
        expect(game_rules_4board_empty.winner?(player_moves)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do
        player_moves = [4,2,3,9]
        expect(game_rules_4board_empty.winner?(player_moves)).to eq(false)
      end
    end
  end

  describe '#find_winning_columns' do
      it 'identifies the columns with winning combinations for 3-in-a-row by default' do
        expect(game_rules_3board_empty.find_winning_columns).to eq([[0,3,6], [1,4,7], [2,5,8]])
      end

    it 'identifies the columns with winning combinations for 4-in-a-row' do
      expect(game_rules_4board_empty.find_winning_columns).to eq([[0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15]])
    end
  end

  describe '.find_winning_rows' do
    it 'identifies the rows with winning combinations for 3-in-a-row by default' do
      expect(game_rules_3board_empty.find_winning_rows).to eq([[0,1,2],[3,4,5],[6,7,8]])
    end

    it 'identifies the rows with winning combinations for 4-in-a-row' do
      expect(game_rules_4board_empty.find_winning_rows).to eq([[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15]])
    end
  end

  describe '.find_winning_left_diagonal' do
    it 'identifies the top left diagonal winning combination for 3-in-a-row by default' do
      expect(game_rules_3board_empty.find_winning_left_diagonal).to eq([0,4,8])
    end

    it 'identifies the top left diagonal winning combination for 4-in-a-row' do
      expect(game_rules_4board_empty.find_winning_left_diagonal).to eq([0,5,10,15])
    end
  end

  describe '.find_winning_right_diagonal' do
    it 'identifies the top right diagonal winning combination for 3-in-a-row by default' do
      expect(game_rules_3board_empty.find_winning_right_diagonal).to eq([2,4,6])
    end

    it 'identifies the top right diagonal winning combination for 4-in-a-row' do
      expect(game_rules_4board_empty.find_winning_right_diagonal).to eq([3,6,9,12])
    end
  end

  describe 'winning move finder methods' do
    context 'Board size agnostic' do
      describe '#find_player_moves_by_indices' do
        it 'returns an array with moves of a given player' do
          expect(game_rules_3board_with_tie.find_player_moves_by_indices('X')).to eq([0,2,5,6,7])
          expect(game_rules_3board_with_tie.find_player_moves_by_indices('O')).to eq([1,3,4,8])
        end
      end

      describe '#winner?' do
        it 'returns true if array of moves has a winning combination' do
          player_moves = [0,1,2]
          expect(game_rules_3board_empty.winner?(player_moves)).to eq(true)
        end

        it 'returns false if array of players moves does not have a winning combo' do
          player_moves = [1,2,3]
          expect(game_rules_3board_empty.winner?(player_moves)).to eq(false)
        end

        it 'returns true if player moves has a winning combination' do
          player_moves = [0,1,2,3]
          expect(game_rules_4board_empty.winner?(player_moves)).to eq(true)
        end

        it 'returns false if player moves does not have a winning combination' do
          player_moves = [4,2,3,9]
          expect(game_rules_4board_empty.winner?(player_moves)).to eq(false)
        end
      end

      describe 'tie?' do
        it 'returns true if move_count is the same as board_size-- no more available moves' do
          expect(game_rules_3board_with_tie.tie?).to eq(true)
        end

        it 'returns false if there are still open moves on the board' do
          expect(game_rules_3board_empty.tie?).to eq(false)
        end

        it 'returns false if there is a winning player on a full board' do
          expect(game_rules_3board_with_winner.tie?).to eq(false)
        end
      end

      describe '#check_for_win' do
        it 'returns false if number of moves played by a player is less than 3, the minimum number needed for a win' do
          expect(game_rules_3board_empty.check_for_win?(game_rules_3board_empty.player1_symbol)).to eq(false)
        end

        it 'returns false if moves played by a player does not include a winning combination, irrspective of moves_played order' do
          expect(game_rules_3board_with_winner.check_for_win?(game_rules_3board_with_winner.player2_symbol)).to eq(false)
        end

        it 'returns true if moves played by a player includes a winning combination, irrespective of moves_played order' do
          expect(game_rules_3board_with_winner.check_for_win?(game_rules_3board_with_winner.player1_symbol)).to eq(true)
        end
      end

      describe '#winner_on_the_board?' do
        it 'returns true if either player has a winning combination' do
          expect(game_rules_3board_with_winner.winner_on_the_board?).to eq(true)
        end

        it 'returns false if neither player has a winning move combination' do
          expect(game_rules_3board_with_tie.winner_on_the_board?).to eq(false)
        end
      end
    end
  end
end

def make_full_3board_tie(board)
  board.preload_game_board_spaces(
    ["X", "O", "X",
     "O", "O", "X",
     "X", "X", "O"])
=begin
X | O | X
O | O | X
X | X | O
=end
end

def make_full_3board_winner(board)
  board.preload_game_board_spaces(
    ["X", "O", "O",
     "X", "O", "X",
     "X", "X", "O"])
=begin
X | O | X
O | O | X
X | X | O
=end
end


def make_full_4board(board)
  board.preload_game_board_spaces = (
    ["X", "O", "X", "O",
     "O", "O", "X", "X",
     "X", "X", "O", "O",
     "X", "O", "X", "O"])
=begin
X | O | X | O
O | O | X | X
X | X | O | O
X | O | X | O
=end
end


