class HumanPlayer
  attr_accessor :moves_played, :player_symbol 

  def initialize game_rules, player_symbol = 'X'
    @player_symbol = player_symbol
  end 

  def make_move board
    gets.chomp.to_i
  end

end
