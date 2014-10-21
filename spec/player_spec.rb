require_relative '../lib/player'

describe Player do
  
  it 'initializes a Player Object with a symbol attribute' do
    new_player = Player.new('X')
    expect(new_player.player_symbol).to eq('X')
  end

  it 'initializes a Player Object with an empty moves_played attribute' do
    new_player = Player.new('X')
    expect(new_player.moves_played).to eq([])
  end

end
