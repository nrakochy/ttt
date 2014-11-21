require_relative '../lib/easy_ai_player'
require_relative '../lib/board'
require_relative '../lib/game_rules'

describe EasyAIPlayer do
  
  it 'initializes a Player Object with a symbol attribute' do
    rules = []
    new_player = EasyAIPlayer.new(rules, 'X')
    expect(new_player.player_symbol).to eq('X')
  end

  describe '#make_move' do
    it 'returns only integers from board' do
      game_rules = GameRules.new
      board = Board.new(game_rules)
      new_player = EasyAIPlayer.new(game_rules)
      expect(new_player.make_move(board)).to eq(1)
    end
  end

end
