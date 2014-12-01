require_relative '../lib/human_player'
require_relative '../lib/game_rules'
require_relative '../lib/board'

describe HumanPlayer do
  let(:board){ Board.new }
  let(:rules){ GameRules.new(board) }

  it 'initializes a Player Object with a symbol attribute' do
    new_player = HumanPlayer.new(rules,'X')
    expect(new_player.player_symbol).to eq('X')
  end

end
