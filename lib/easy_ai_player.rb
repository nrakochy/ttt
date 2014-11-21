class EasyAIPlayer
  attr_reader :player_symbol

  def initialize game_rules, player_symbol = 'O'
      @player_symbol = player_symbol
  end

  def make_move(board)
      board.find_open_spaces.first
  end

end
