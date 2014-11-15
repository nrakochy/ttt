require_relative '../lib/hard_ai_player'
require_relative '../lib/game_rules'
require_relative '../lib/board'
require 'pry'

describe HardAIPlayer do
  let(:rules){ GameRules.new }
  let(:hard_ai){ HardAIPlayer.new(@full_board)}
  let(:empty_board) { Board.new(rules) }
  let(:player_with_empty_board) { HardAIPlayer.new(empty_board) }

  describe 'negamax helper methods' do
    before :each do
      board_spaces = (1..9).to_a
      player1_indices = [0,3,4,5,7]
      player2_indices = [1,2,6,8]
      board1 = make_moves(player1_indices, board_spaces, "X")
      board_both = make_moves(player2_indices, board1, "O")
      @full_board = Board.new(rules, 9, board_both)

=begin 

        X  |  O  |  O

        X  |  X  |  X

        O  |  X  |  O

=end
    end

    context '3x3 board' do
      describe '#initialize' do
        it 'initializes with symbol attribute for player and opponent' do
          expect(hard_ai.player2_symbol).to eq('O')
          expect(hard_ai.player1_symbol).to eq('X')
        end
      end

      describe '#winner?' do
        it 'returns true if the board includes winning combination for a specific player' do
          expect(hard_ai.winner?(hard_ai.player1_symbol)).to eq(true)
        end

        it 'returns false if the board does not include a winning combination for a specific player' do
          expect(hard_ai.winner?(hard_ai.player2_symbol)).to eq(false)
        end
    end

    describe '#score_board_state' do
      it 'returns -1 if board_state results in win for player1' do
        depth = 1
        expect(hard_ai.score_board_state(depth)).to eq(-1)
      end

      it 'returns 0.0 if possible move is not a winning move' do
        depth = 1
        expect(player_with_empty_board.score_board_state(depth)).to eq(0.0)
      end
    end

    describe '#tie?' do
      it 'returns true if there is a winner on the board' do
        expect(hard_ai.tie?).to eq(true)
      end
    end

    describe '#game_over' do
      it 'returns false if there is no winner and remaining moves to be played' do
        expect(player_with_empty_board.game_over?).to eq(false)
      end

      it 'returns true if player moves contains a winnning combination' do
        expect(hard_ai.game_over?).to eq(true)
      end
    end
   end

  describe '#create_score_for_each_available_move' do
    context '2 remaining moves' do
      it 'returns hash { 4 => -1, 6 => 0.0 }, with 4 resulting in a loss and 6 resulting in a tie' do
        board_spaces = (1..9).to_a
        player1_indices = [0,2,7,8]
        player2_indices = [1,4,6]
        board1 = make_moves(player1_indices, board_spaces, "X")
        board_both = make_moves(player2_indices, board1, "O")
        board = Board.new(rules, 9, board_both)
        ai = HardAIPlayer.new(board)
        expect(ai.create_score_for_each_available_move(board)).to eq( {4 => -1, 6=> 0.0 } )

=begin 

        X  |  O  |  X

        4  |  O  |  6

        O  |  X  |  X

=end
      end

      it 'returns hash { 2 => 1, 7 => 1 }, with both moves resulting in a win for player2' do
        board_spaces = (1..9).to_a
        player1_indices = [0,3,5,8]
        player2_indices = [2,4,7]
        board1 = make_moves(player1_indices, board_spaces, "X")
        board_both = make_moves(player2_indices, board1, "O")
        board = Board.new(rules, 9, board_both)
        ai = HardAIPlayer.new(board)
        expect(ai.create_score_for_each_available_move(board)).to eq({ 2=>-1, 7=>-1  } )

=begin

        X  |  2  |  O

        X  |  O  |  X

        7  |  O  |  X

=end
      end
    end
  end
  describe '#make_move TEST NOT WRITTEN YET' do
    context '3x3 board'
      it 'returns the next best move' do
        board_spaces = (1..9).to_a
        player1_indices = [0,2,7,8]
        player2_indices = [1,4,6]
        board1 = make_moves(player1_indices, board_spaces, "X")
        board_both = make_moves(player2_indices, board1, "O")
        board = Board.new(rules, 9, board_both)
        ai = HardAIPlayer.new(board)
        expect(ai.create_score_for_each_available_move(board)).to eq( {4 => -1, 6=> 0.0 } )

=begin

        X  |  O  |  X

        4  |  O  |  6

        O  |  X  |  X

=end
      end
    end
  end
end

def make_moves(player_move_indices, board, player_symbol)
  player_move_indices.each{ |index| board[index] = player_symbol }
  board
end
