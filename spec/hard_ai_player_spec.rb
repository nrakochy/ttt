require_relative '../lib/hard_ai_player'
require_relative '../lib/game_rules'
require_relative '../lib/board'
require 'pry'

describe HardAIPlayer do
  let(:rules){ GameRules.new }
  let(:hard_ai){ HardAIPlayer.new(rules,@board)}


  it 'initializes a Player Object with a symbol attribute' do
    expect(hard_ai.player_symbol).to eq('O')
  end

  describe 'negamax helper methods' do
    before :each do 
        available_spaces = [2,8]
        already_been_taken = [1,3,4,5,6,7,9]
        @board = Board.new(available_spaces, already_been_taken) 
      end

   context '3x3 board' do
    describe '#winner?' do
      it 'returns true if player_moves includes winning combination' do
        moves_played = [1,2,3]
        @board.player1_already_played = moves_played
        expect(hard_ai.winner?(@board.player1_already_played)).to eq(true)
      end

      it 'returns false if player_moves does not include winning combination' do
        moves_played = [2,3,4]
        @board.player1_already_played = moves_played
        expect(hard_ai.winner?(moves_played)).to eq(false)
      end
    end

    describe '#score_board_state' do
      it 'returns 10.0 if possible move results in win for the player' do
        @board.player2_already_played = [1,2,3]
        player_turn = 1
        expect(hard_ai.score_board_state(@board, player_turn)).to eq(10.0)

      end

      it 'returns 0.0 if possible move is not a winning move' do
        possible_board = [2,3,4]
        depth = 0
        expect(hard_ai.score_board_state()).to eq(0.0)
      end
    end

    describe '#tie?' do
      it 'returns true if there are no moves left' do 
        possible_moves = []
        expect(hard_ai.tie?(possible_moves)).to eq(true)
      end

      it 'returns false if there are remaining moves in the Board to be played' do
        available_spaces = [1,2]
        expect(hard_ai.tie?(available_spaces)).to eq(false)
      end
    end

    describe '#game_over' do
      it 'returns true if game ends in a tie ' do
        board = []
        current_player = []
        expect(hard_ai.game_over?(board, current_player)).to eq(true)
      end

      it 'returns true if player moves contains a winnning combination' do
        moves_played = [1,2,3]
        board = [7,8]
        expect(hard_ai.game_over?(board, moves_played)).to eq(true)
      end
    end

    describe '#create_scores_for_each_available_move' do
      context '2 remaining moves' do
        it 'returns a scores hash with available_moves for each key and their score as determined by negamax for the value' do
          available_spaces = [8,6]
          player2 = [5,7]
          player1 = [1,3,4,7,9]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          ai = HardAIPlayer.new(rules, board_state)
          expect(ai.create_scores_for_each_available_move(board_state)).to eq( { 8 => 10.0, 6 => 0.0} )
        end
      end
    end
   end

    describe '#negamax' do
      context '1 remaining move' do
        it 'returns 0.0 for the last available space' do
          available_spaces = [2]
          player2 = [3,4,5,8]
          player1 = [1,6,7,9]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          ai = HardAIPlayer.new(rules, board_state)
          expect(ai.negamax(board_state)).to eq( 0.0 )
        end
      end

      context '2 remaining moves' do
        it 'returns 0.0 for the two remaining moves' do
          available_spaces = [2,8]
          player2 = [3,4,5]
          player1 = [1,6,7,9]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          expect(hard_ai.negamax(board_state)).to eq( 0.0 )
        end

        it 'returns 10.0 for the two remaining moves, starting with 6, resulting in win for current_player turn' do
          available_spaces = [6,8]
          player2 = [3,4,9]
          player1 = [1,2,5,7]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          expect(hard_ai.negamax(board_state)).to eq( 10.0 )
        end

        it 'returns 0.0 for the two remaining moves, starting with 8, resulting in tie' do
          available_spaces = [8,6]
          player2 = [3,4,9]
          player1 = [1,2,5,7]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          expect(hard_ai.negamax(board_state)).to eq( 0.0 )
        end

        it 'returns 10.0 for the two remaining moves, starting with 8, resulting in loss for the current_player' do
          available_spaces = [8,6]
          player2 = [5,7]
          player1 = [1,3,4,7,9]
          already_been_taken = player1 + player2
          board_state = Board.new(available_spaces, already_been_taken, player1, player2)
          expect(hard_ai.negamax(board_state)).to eq( 10.0 )
        end
      end

      context '3 remaining moves' do
      end
    end
  end
end
