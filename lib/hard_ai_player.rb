class HardAIPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize player_symbol, moves_played = []
      @moves_played = moves_played
      @player_symbol = player_symbol
  end 

  def make_move board
    board.sample
  end

  def get_next_best_move
  end

  def minimax possible_moves

  end

end
