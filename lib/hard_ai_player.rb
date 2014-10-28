class HardAIPlayer
  attr_reader :moves_played, :player_symbol 

  def make_move board
    board.sample
  end

  def get_next_best_move 
  end

  def minimax possible_moves
  end

  def check_for_win possible_moves, winning_combos, board_size = 3
    possible_moves.each do |move|
    end
  end
end
