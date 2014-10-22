require_relative '../lib/human_player'

describe HumanPlayer do
  
  it 'initializes a Player Object with a symbol attribute' do
    new_player = HumanPlayer.new('X')
    expect(new_player.player_symbol).to eq('X')
  end

  it 'initializes a Player Object with an empty moves_played attribute' do
    new_player = HumanPlayer.new('X')
    expect(new_player.moves_played).to eq([])
  end

end
