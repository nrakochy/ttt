require 'pry'
class EasyAIPlayer
  attr_reader :player_symbol

  def initialize game_rules, player_symbol = 'O'
      @player_symbol = player_symbol
  end

  def make_move(board)
    move = "not_an_integer"
    while move.class != Fixnum
      move = board.game_board.sample
    end
    move
  end

end
