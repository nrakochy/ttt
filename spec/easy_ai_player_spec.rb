require_relative '../lib/easy_ai_player'

describe EasyAIPlayer do
  
  it 'initializes a Player Object with a symbol attribute' do
    rules = []
    board = []
    new_player = EasyAIPlayer.new(rules, board, 'X')
    expect(new_player.player_symbol).to eq('X')
  end

  describe '#make_move' do
    it 'returns only integers from board' do
      move_spaces = [1, "2"]
      new_player = EasyAIPlayer.new([], move_spaces)
      expect(new_player.make_move).to eq(1)
    end
  end

end
