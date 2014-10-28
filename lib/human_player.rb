class HumanPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize player_symbol, moves_played = []
    @moves_played = moves_played
    @player_symbol = player_symbol
  end 

  def make_move board, player_moves_played = [], opponent_moves_played = []
    move = gets.chomp.to_i
    i = 0
    while invalid_move?(move, board) && i < 5
      Output.invalid_move
      i += 1
      move = gets.chomp.to_i
    end
    if invalid_move?(move, board) && i == 5 
      Output.forfeit
      # Abort the game
    else 
      move
    end
  end

  def invalid_move? move, board
    !board.include?(move)
  end
end
