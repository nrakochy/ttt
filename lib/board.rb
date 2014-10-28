class Board 
  attr_reader :board_spaces

  def new_board (height= 3, width = 3)
    board = []
    board_size = height * width
    board_size.times{|num| board << (num+1) }
    @board_spaces = board
  end
  
  def apply_move_to_board(board_elements, player_move)
    board_elements.delete(player_move)
    board_elements
  end
  
  def all_moves_played (board_state, original_board)
    original_board.delete_if{|num| board_state.include?(num)}
  end

  def valid_move? move, board_state
    board_state.include?(move)
  end

end
