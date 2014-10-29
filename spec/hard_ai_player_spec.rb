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
        expect(new_player.winner?(moves_played, rules)).to eq(true)
      end

      it 'returns false if player_moves includes winning combination' do
        moves_played = [2,3, 4]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.winner?(moves_played, rules)).to eq(false)
      end

    describe '#loser?' do
      it 'returns true if opponents_moves includes winning combination' do
        moves_played = [1,2,3]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.loser?(moves_played)).to eq(true)
      end

      it 'returns true if opponents_moves includes winning combination' do
        moves_played = [2,3,4]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules, moves_played)
        expect(new_player.loser?(moves_played)).to eq(false)
      end
    end

    describe '#score_board_state' do
      it 'returns 10.0 if possible move results in win for the player' do
        possible_board = [1,2,3]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.score_board_state(possible_board)).to eq(10.0)
      end

      it 'returns 0.0 if possible move results in win for the player' do
        possible_board = [2,3,4]
        rules.find_winning_combinations
        new_player = HardAIPlayer.new(rules)
        expect(new_player.score_board_state(possible_board)).to eq(0.0)
      end

    end




      
    end
  end


  describe '#score_board_state' do
    context '3x3 board' do
      it 'returns score of 10 with winning board' do
        potential_move = 1
        player_moves =  [2,3]

      end

      it  'Current Player needs to block a losing move in the current Board State' do
      end

      it  'Current Player has neither winning move to make or losing move to block' do
      end

    context '4x4 board' do
    end
    end
  end

end
