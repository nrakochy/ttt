class EasyAIPlayer
  attr_reader :player_symbol

  def initialize(game_rules, player_symbol)
      @player_symbol = player_symbol
      @board = game_rules.board
  end

  def make_move
    @board.find_open_spaces.first
  end

end
