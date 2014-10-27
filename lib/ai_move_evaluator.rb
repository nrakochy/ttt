require 'board'

class AIMoveEvaluator
  include Board

  def initialize player1_moves_played = [], player2_moves_played = []
    @player1_moves_played = player1_moves_played
    @player2_moves_played = player2_moves_played
  end

  def check_for_win? 

  end

  def check_for_loss?
  end
end
