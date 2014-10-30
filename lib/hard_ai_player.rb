require 'pry'
class HardAIPlayer
  attr_reader :board, :moves_played, :player_symbol 
  
  def initialize(game_rules, moves_played = [], player_symbol = 'O')
    @rules = game_rules
    @moves_played = moves_played
    @player_symbol = player_symbol
  end

  def winner?(player_moves = self.moves_played)
    @rules.winner?(player_moves, @rules.winning_combos)
  end

  def loser? player_moves = opponent.moves_played 
    winner?(player_moves, @rules.winning_combos)
  end

  def make_move current_board
    
  end

  def score_board_state(possible_board) 
    winner?(possible_board, @rules.winning_combos) ? 10.0 : 0.0
  end

  def minimax possible_moves
  end

end
