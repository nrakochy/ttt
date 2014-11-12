require 'pry'
class Board 
  attr_accessor :all_moves_played, :player1_already_played, :player2_already_played, :available_spaces

  def initialize available_spaces = [], all_moves_played = [], player1_already_played = [], player2_already_played = []
    @all_moves_played = all_moves_played
    @available_spaces = available_spaces
    @player1_already_played = player1_already_played
    @player2_already_played = player2_already_played
  end

  def new_board (height= 3, width = 3)
    board = []
    board_size = height * width
    board_size.times{|num| board << (num+1) }
    @available_spaces = board
  end
  
  def shift_move_from_available_to_played(player_move)
    all_moves_played << available_spaces.delete(player_move)
  end

  def add_move_to_players_moves(player_move, player_already_moved)
    player_already_moved << player_move
  end

  def apply_move_to_board(player_move, player_already_moved = [])
    add_move_to_players_moves(player_move, player_already_moved)
    shift_move_from_available_to_played(player_move)
  end


  def valid_move? move, board_state
    board_state.include?(move)
  end

  def undo_move(moves_to_reset)
    moves_to_reset.each do |move|
      player1_already_played.delete(move) if player1_already_played.include?(move)
      player2_already_played.delete(move) if player2_already_played.include?(move)
      available_spaces << all_moves_played.delete(move)
    end
    self
  end  

end
