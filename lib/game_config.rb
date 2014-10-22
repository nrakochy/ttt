require_relative 'output'

class GameConfig

  def choose_opponent 
    Output.choose_opponent
    gets.chomp.upcase
  end

  def choose_board_size
    dimensions = []
    Output.board_size_height
    dimensions << gets.chomp
    Output.board_size_width
    dimensions << gets.chomp
  end

  def player_symbol
    Output.choose_player_symbol
    gets.chomp
  end

end
