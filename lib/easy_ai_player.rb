class EasyAIPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize player_symbol = 'O', moves_played = []
      @moves_played = moves_played
      @player_symbol = player_symbol
  end 

  def make_move board
    board.sample
  end

end
