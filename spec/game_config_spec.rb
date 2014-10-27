require_relative '../lib/game_config'

describe GameConfig do
  let(:game){ GameConfig.new }

  it '#choose_opponent returns string of user input for opponent choice' do
    allow(game).to receive(:gets){ "E" }
    expect(game.choose_opponent).to eq("E")
  end

  it '#choose_board_size_height gets user input for board height and converts to an integer' do
    allow(game).to receive(:gets){ "4" }
    expect(game.choose_board_size_height).to eq(4)
  end

  it '#choose_board_size_width gets user input for board height and converts to integer' do
    allow(game).to receive(:gets){ "4 "}
    expect(game.choose_board_size_width).to eq(4)
  end

  it '#player_symbol returns string of user input as player_symbol ' do
    allow(game).to receive(:gets) { ":)"}
    expect(game.player_symbol).to eq(":)")
  end
end
