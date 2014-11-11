class EasyAIPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize game_rules, current_board, player_symbol = 'O', moves_played = []
      @moves_played = moves_played
      @player_symbol = player_symbol
  end 

  def make_move board
    board.available_spaces.sample.to_i
  end

end
