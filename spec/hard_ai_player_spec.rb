require_relative '../lib/hard_ai_player'
require_relative '../lib/game_rules'
require_relative '../lib/board'

describe HardAIPlayer do
  let(:rules_with_full_board){ GameRules.new(@full_board) }
  let(:rules_with_empty_board){ GameRules.new(empty_board)}
  let(:hard_ai_with_full_board){ HardAIPlayer.new(rules_with_full_board) }
  let(:empty_board){ Board.new }
  let(:hard_ai_with_empty_board) { HardAIPlayer.new(rules_with_empty_board) }

  describe 'negamax helper methods' do
    before :each do
      new_board = Board.new
      @full_board = new_board.preload_game_board_spaces(
        ["X", "O", "O", "X", "X", "X", "O", "X", "O"])

=begin

        X  |  O  |  O

        X  |  X  |  X

        O  |  X  |  O

=end
    end

    context '3x3 board' do
      describe '#initialize' do
        it 'initializes with symbol attribute for player and opponent' do
          expect(hard_ai_with_full_board.player_symbol).to eq('O')
          expect(hard_ai_with_full_board.opponent_symbol).to eq('X')
        end
      end

    describe '#winner?' do
      it 'returns true if the board includes winning combination for a specific player' do
        expect(hard_ai_with_full_board.winner_on_the_board?).to eq(true)
      end

      it 'returns false if the board does not include a winning combination for a specific player' do
        expect(hard_ai_with_empty_board.winner_on_the_board?).to eq(false)
      end
    end

    describe '#score_board_state' do
      it 'returns -1 if board_state results in win for player1' do
        depth = 1
        expect(hard_ai_with_full_board.score_board_state(depth)).to eq(-1)
      end

      it 'returns 0.0 if possible move is not a winning move' do
        depth = 1
        expect(hard_ai_with_empty_board.score_board_state(depth)).to eq(0.0)
      end
    end

    describe '#tie?' do
      it 'returns false if there is a winner on the board even if board is full' do
        expect(hard_ai_with_full_board.tie?).to eq(false)
      end
    end

    describe '#game_over' do
      it 'returns true if there is a tie? or a winner?' do
        expect(hard_ai_with_full_board.game_over?).to eq(true)
      end

      it 'returns false if there is no winner and still open spaces available' do
        expect(hard_ai_with_empty_board.game_over?).to eq(false)
      end
    end
   end

  describe '#create_score_for_each_available_move' do
    context '2 remaining moves' do
      it 'returns hash { 4 => -1, 6 => 0.0 }, with 4 resulting in a loss and 6 resulting in a tie' do
        new_board = empty_board.preload_game_board_spaces(
         ["X", "O", "X", 4, "O", 6, "O", "X", "X"])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.create_score_for_each_available_move).to eq( {4 => -1, 6=> 0.0 } )

=begin

        X  |  O  |  X

        4  |  O  |  6

        O  |  X  |  X

=end
      end

      it 'returns hash { 2 => 1, 7 => 1 }, with both moves resulting in a win for player2' do
        new_board = empty_board.preload_game_board_spaces(
          ["X", 2, "O", "X", "O", "X", 7, "O", "X"])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.create_score_for_each_available_move).to eq({ 2=> 1, 7=> 1  } )

=begin

        X  |  2  |  O

        X  |  O  |  X

        7  |  O  |  X

=end
      end
    end
  end
  describe '#make_move' do
    context '3x3 board'
      it 'takes the winning space if available' do
         new_board = empty_board.preload_game_board_spaces(
          ["X", "O", "X", "X", "O", 6, "O", 8, "X"])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.make_move).to eq( 8 )

=begin

        X  |  O  |  X

        X  |  O  |  6

        O  |  8  |  X

=end
      end

      it 'blocks the losing space if no winning move is available' do
         new_board = empty_board.preload_game_board_spaces(
          ["O", "O", "X", "X", "X", 6, "O", 8, "X"])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.make_move).to eq( 6 )

=begin

        O  |  O  |  X

        X  |  X  |  6

        O  |  8  |  X

=end
      end

      it 'blocks the losing space with higher integer number than other available, non-winning open space' do
       new_board = empty_board.preload_game_board_spaces(
          ["X", "O", "X", "O", "X", "X", "O", 8, 9])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.make_move).to eq( 9 )

=begin

        X  |  O  |  X

        O  |  X  |  X

        O  |  8  |  9

=end
      end

      it 'does not allow itself to be forked, which would create two winning moves for the opponent' do
       new_board = empty_board.preload_game_board_spaces(
          [1, 2, "X", 4, "O", 6, "X", 8, 9])
        rules_with_preloaded_board = GameRules.new(new_board)
        ai = HardAIPlayer.new(rules_with_preloaded_board)
        expect(ai.make_move).not_to eq( 1 )
        expect(ai.make_move).not_to eq( 9 )

=begin

        1  |  2  |  X

        4  |  O  |  6

        X  |  8  |  9

=end
      end
    end
  end
end
