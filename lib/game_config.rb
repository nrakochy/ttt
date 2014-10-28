require_relative 'io'

class GameConfig

  def initialize io = BoardIO.new
    @io = io
  end

  def customize_else_3_in_a_row
    @io.customize_board_or_choose_opponent
    input = @io.user_input.upcase
    "CUSTOMIZE" if input == 'C'
  end

  def choose_opponent 
    @io.choose_opponent
    @io.user_input.to_i
  end

  def choose_board_size_height
    @io.board_size_height
    @io.user_input.to_i
     #VALIDATE INPUT
  end

  def choose_board_size_width
    @io.board_size_width
    @io.user_input.to_i
  end

  def player_symbol
    @io.player_symbol
    @io.user_input
  end

end
