require_relative '../lib/human_player'

describe HumanPlayer do

  it 'initializes a Player Object with a symbol attribute' do
    new_player = HumanPlayer.new('X')
    expect(new_player.player_symbol).to eq('X')
  end

end
