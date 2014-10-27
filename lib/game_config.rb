require_relative 'output'
require_relative 'get_input'

class GameConfig

  def initialize
    @output = Output.new
    @get_input = GetInput.new
  end

  def choose_opponent 
    @output.choose_opponent
    @get_input.user_input.upcase
  end

  def self.choose_board_size_height
    @output.choose_board_size_height
    input = @get_input.user_input
     #VALIDATE INPUT
  end

  def self.choose_board_size_width
    @output.choose_board_size_width
    input = @get_input.user_input
    #VALIDATE INPUT
  end

  def self.player_symbol
    @output.player_symbol
    @get_input.user_input
  end

end
