require 'pry'
class HardAIPlayer
  attr_reader :player_symbol, :current_board
  
  def initialize(game_rules, current_board, modified_board = [], player_symbol = 'O')
    @rules = game_rules
    @player_symbol = player_symbol
    @current_board = current_board
  end

  def make_move board
    
  end

  def create_scores_for_each_available_move(board, scores = {})
    board.available_spaces.each do |move|
      board.apply_move_to_board(move, board.player2_already_played)
      scores[move] = -negamax(board)
      board.undo_move(move)
    end
    scores
  end

  def negamax(board, depth = 1, player_turn = 1)
    return score_board_state(board, player_turn) if game_over?(board)
    score = -9999
    board.available_spaces.each do |move|
      if player_turn < 0
        board.apply_move_to_board(move, board.player2_already_played)
      else
        board.apply_move_to_board(move, board.player1_already_played)
      end
      negamax_result = -negamax(board, depth + 1, -player_turn)
      score = [score, negamax_result].max
      board.undo_move(move)
    end
    score
  end

  def score_board_state(board_obj, player_turn)
    if winner?(board_obj.player1_already_played) || winner?(board_obj.player2_already_played)
      10.0 * player_turn
    else
      0.0
    end
  end

  def game_over?(board_obj)
    tie?(board_obj.available_spaces) || winner?(board_obj.player1_already_played) || winner?(board_obj.player2_already_played)
  end

  def tie?(board_state)
    board_state.empty?
  end

  def winner? board_state
    @rules.winner?(board_state, @rules.winning_combos)
  end

end
