require_relative '../lib/console'

class HumanPlayer
  attr_accessor :moves_played, :player_symbol

  def initialize game_rules, player_symbol = 'X'
    @console = Console.new
    @player_symbol = player_symbol
  end

  def make_move board
    @console.user_input.to_i
  end

end
