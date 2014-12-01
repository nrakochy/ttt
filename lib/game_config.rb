require_relative 'console_messages_presenter'

class GameConfig

  def initialize(console)
    @console = console
  end

  def customize_else_3_in_a_row
    @console.customize_board_or_choose_opponent
    input = @console.user_input.upcase
    "CUSTOMIZE" if input == 'C'
  end

  def choose_opponent
    @console.choose_opponent
    @console.user_input.to_i
  end

  def choose_board_size_height
    @console.board_size_height
    @console.user_input.to_i
  end

  def choose_board_size_width
    @console.board_size_width
    @console.user_input.to_i
  end

  def player_symbol
    @console.player_symbol
    @console.user_input
  end

end
