require_relative '../lib/hard_ai_player'
require_relative '../lib/game_rules'

describe HardAIPlayer do

  let(:rules){ GameRules.new }

  it 'initializes a Player Object with a symbol attribute' do
    new_player = HardAIPlayer.new(rules)
    expect(new_player.player_symbol).to eq('O')
  end

  it 'initializes a Player Object with an empty moves_played attribute' do
    new_player = HardAIPlayer.new(rules)
    expect(new_player.moves_played).to eq([])
  end

  context '3x3 board' do
    describe '#winner?' do
      it 'returns true if player_moves includes winning combination' do
        moves_played = [1,2,3]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.winner?(moves_played)).to eq(true)
      end

      it 'returns false if player_moves does not include winning combination' do
        moves_played = [2,3,4]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.winner?(moves_played)).to eq(false)
      end
    end

    describe '#score_board_state' do
      it 'returns 10.0 if possible move results in win for the player' do
        possible_board = [1,2,3]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.score_board_state(possible_board, 1)).to eq(10.0)
      end

      it 'returns 0.0 if possible move is not a winning move' do
        possible_board = [2,3,4]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.score_board_state(possible_board)).to eq(0.0)
      end
    end

    describe '#tie?' do
      it 'returns true if there are no moves left and there is no winning move' do
        possible_moves = []
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.tie?(possible_moves)).to eq(true)
      end

      it 'returns false if there are remaining moves in the Board to be played' do
        possible_moves = [1,2]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.tie?(possible_moves)).to eq(false)
      end
    end

    describe '#game_over' do
      it 'returns true if game ends in a tie ' do
        board = []
        expect(HardAIPlayer.new(rules).game_over?(board)).to eq(true)
      end

      it 'returns true if player moves contains a winnning combination' do
        moves_played = [1,2,3]
        board = [7,8]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.game_over?(board, moves_played)).to eq(true)
      end
    end

    describe '#minimax' do
      context '1 remaining move, opponent turn to move' do
        it 'returns the value of 0.0 for last remaining possible move which ends in a tie for the opponent and a win for the player' do
          current_board = [6]
          moves_played = [3,4,5]
          opponent_moves = [1]
          rules.find_winning_combinations
          new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
          expect(new_player.minimax(current_board, moves_played)).to eq( 0.0 )
        end

        it 'returns the value of -10.0 for last remaining possible move which results in victory for opponent' do
          current_board = [3]
          moves_played = [9,4,5]
          opponent_moves = [1,2,7]
          rules.find_winning_combinations
          new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
          expect(new_player.minimax(current_board, moves_played)).to eq( -10.0 )
        end
      end

      context '2 remaining moves, opponent turn to move' do
        it 'returns a value of -10 as value for fork in which opponent will win at either move' do
          current_board = [8,9]
          moves_played = [3,4,6]
          opponent_moves = [1,2,5]
          rules.find_winning_combinations
          new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
          expect(new_player.minimax(current_board, moves_played)).to eq( -10.0 )
        end

        it 'returns the value of 0 for the two remaining moves, one of which ends in a loss for the opponent and one ends in a tie for the opponent' do
          current_board = [6,3]
          moves_played = [1,2]
          opponent_moves = [5]
          rules.find_winning_combinations
          new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
          expect(new_player.minimax(current_board, moves_played)).to eq( 0.0 )
        end
      end

      context '3 remaining moves, opponent turn to move' do
        it 'returns a value of 0.0 for remaining possible moves which include player victory, expecting opponent block' do
          current_board = [7,5,9]
          moves_played = [4,6]
          opponent_moves = [1]
          rules.find_winning_combinations
          new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
          expect(new_player.minimax(current_board, moves_played)).to eq( 0.0 )
        end

      it 'returns a value of 10.0 as value for possible move that contains a win down the tree, expecting opponent block' do
        current_board = [6,7,8]
        moves_played = [1,2,3]
        opponent_moves = [4,5,9]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played, opponent_moves)
        expect(new_player.minimax(current_board, moves_played)).to eq( 10.0 )
      end
      end
    end
  end
end
