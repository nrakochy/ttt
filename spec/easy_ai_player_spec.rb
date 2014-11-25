require_relative '../lib/easy_ai_player'
require_relative '../lib/board'
require_relative '../lib/game_rules'

describe EasyAIPlayer do
  let(:board){ Board.new }
  let(:game_rules){ GameRules.new(board) }
  let(:player){ EasyAIPlayer.new(game_rules) }
  
  it 'initializes a Player Object with a symbol attribute' do
    expect(player.player_symbol).to eq('O')
  end

  describe '#make_move' do
    it 'returns 1, the first available open space on the game board' do
      expect(player.make_move).to eq(1)
    end
  end

end
