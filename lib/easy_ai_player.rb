class EasyAIPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize player_symbol, moves_played = []
      @moves_played = moves_played
      @player_symbol = player_symbol
  end 

  def make_move board, player_moves_played = [], opponent_moves_played = []
    board.sample.to_i
  end

end