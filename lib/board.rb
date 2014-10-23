class Board
  attr_accessor :winner, :board_spaces

  def initialize winning_combos, board_spaces
    @winner = winning_combos
    @board_spaces = board_spaces
  end

  def apply_move_to_board(board_spaces, player_move)
    board_spaces.delete(player_move)
    board_spaces
  end

  def winner? player_moves, board_size
    player_combos = player_moves.combination(board_size).to_a
    got_a_winner = false 
    player_combos.each{|arr| got_a_winner = true if @winner.include?(arr)}
    got_a_winner
  end 
  
  def all_moves_played (board_state, original_board)
    original_board.delete_if{|num| board_state.include?(num)}
  end

  def valid_move? move, board_state
    board_state.include?(move)
  end

  

end
