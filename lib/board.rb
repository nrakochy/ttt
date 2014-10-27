module Board

  def apply_move_to_board(board_spaces, player_move)
    board_spaces.delete(player_move)
    board_spaces
  end

  def winner? player_moves, winning_combos, board_size = 3
    player_combos = player_moves.combination(board_size).to_a
    got_a_winner = false 
    player_combos.each{|arr| got_a_winner = true if winning_combos.include?(arr)}
    got_a_winner
  end 
  
  def loser? player_moves, board_size
    winner?(player_moves, board_size)
  end
  
  def all_moves_played (board_state, original_board)
    original_board.delete_if{|num| board_state.include?(num)}
  end

  def valid_move? move, board_state
    board_state.include?(move)
  end


end
