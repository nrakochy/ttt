require 'pry'
class Board 
  attr_reader :all_moves_played, :player1_already_played, :player2_already_played, :available_spaces

  def initialize available_spaces = [], all_moves_played = [], player1_already_played = [], player2_already_played = [], game_board = []
    @game_board = game_board
  end

  def new_board (height= 3, width = 3)
    board = []
    board_size = height * width
    board_size.times{|num| board << (num+1) }
    @game_board = board
  end

  def apply_move_to_board(player_move, player_whose_turn_to_play)
    @game_board[player_move + 1] = player_whose_turn_to_play
  end

  def valid_move? move, board_state
    board_state.include?(move)
  end

  def undo_move(player_move)
    @game_board[player_move + 1] = player_move
  end

end
