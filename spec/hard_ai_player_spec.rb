require_relative '../lib/hard_ai_player'

describe HardAIPlayer do
  
  it 'initializes a Player Object with a symbol attribute' do
    new_player = HardAIPlayer.new('X')
    expect(new_player.player_symbol).to eq('X')
  end

  it 'initializes a Player Object with an empty moves_played attribute' do
    new_player = HardAIPlayer.new('X')
    expect(new_player.moves_played).to eq([])
  end

  describe '#minimax' do
    context '3x3 board' do
      it 'Current Player has a winning move option in the current Board State' do
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
