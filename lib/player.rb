class Player
  attr_accessor :moves_played, :player_symbol 

  def initialize player_symbol, moves_played = []
    @moves_played = moves_played
    @player_symbol = player_symbol
  end 

  def make_move 
    gets.chomp.to_i
  end

end
