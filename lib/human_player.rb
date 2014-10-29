class HumanPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize game_rules, player_symbol = 'X', moves_played = []
    @moves_played = moves_played
    @player_symbol = player_symbol
  end 

  def make_move board_obj, player_moves_played = [], opponent_moves_played = []
    move = gets.chomp.to_i
    i = 0
    while invalid_move?(move, board_obj) && i < 5
      BoardIO.invalid_move
      i += 1
      move = gets.chomp.to_i
    end
    if invalid_move?(move, board_obj) && i == 5 
      BoardIO.forfeit
      # Abort the game
    else 
      move
    end
  end

  def invalid_move? move, board
    !board.board_spaces.include?(move)
  end
end
