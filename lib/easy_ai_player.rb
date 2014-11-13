class EasyAIPlayer
  attr_accessor :player_symbol, :board_spaces

  def initialize game_rules, board_spaces, player_symbol = 'O'
      @player_symbol = player_symbol
      @board_spaces = board_spaces
  end

  def make_move
    move = "not_an_integer"
    while move.class != Fixnum
      move = board_spaces.sample
    end
    move
  end

end
