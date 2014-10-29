class EasyAIPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize game_rules, player_symbol = 'O', moves_played = []
      @moves_played = moves_played
      @player_symbol = player_symbol
  end 

  def make_move board, player_moves_played = [], opponent_moves_played = []
    board.board_spaces.sample.to_i
  end

end
