require_relative '../lib/game_config'
require_relative '../lib/fake_io'
require_relative '../lib/console_messages_presenter'
require 'pry'

describe GameConfig do
  let(:io) { FakeIO.new }
  let(:console){ ConsoleMessagesPresenter.new(io) }
  let(:game) {GameConfig.new(console)}

  context 'Board size agnostic' do
    it '#customize_else_3_in_a_row returns CUSTOMIZE for user input of C' do
      io.input << 'C'
      expect(game.customize_else_3_in_a_row).to eq('CUSTOMIZE')
    end

    it '#choose_opponent returns integer of user input for opponent choice' do
      io.input << '1'
      expect(game.choose_opponent).to eq(1)
    end

    it '#choose_board_size_height gets user input for board height and converts to an integer' do
      io.input << '4'
      expect(game.choose_board_size_height).to eq(4)
    end

    it '#choose_board_size_width gets user input for board height and converts to integer' do
      io.input << '4'
      expect(game.choose_board_size_width).to eq(4)
    end

    it '#player_symbol returns string of user input as player_symbol ' do
      io.input << ":)"
      expect(game.player_symbol).to eq(":)")
    end
  end
end
