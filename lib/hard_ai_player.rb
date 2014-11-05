require 'pry'
class HardAIPlayer
  attr_reader :player_symbol, :moves_played 
  
  def initialize(game_rules, moves_played = [], opponent_moves_played = [],  player_symbol = 'O')
    @rules = game_rules
    @moves_played = moves_played
    @opponent_moves_played = opponent_moves_played
    @player_symbol = player_symbol
  end

  def make_move current_board
    available_moves_with_score = evaluate_each_available_move(current_board)
    get_next_best_move(available_moves_with_score)
  end

  def get_next_best_move(available_moves_with_score)
   best_move = available_moves_with_score.max_by{|move, move_score| move_score } 
   best_move[0]
  end

  def evaluate_each_available_move board
    scores = Hash.new
    current_board = board.board_spaces
    current_board.each do |move|
      potential_player_move = @moves_played << move
      current_board.delete(move)
      scores[move] = minimax(current_board, potential_player_move)
      @moves_played.delete(move)
      scores
    end
    scores
  end

  def minimax(current_board, possible_player_board, depth = 0, score = 100)
    if game_over?(current_board, possible_player_board)
      score = score_board_state(possible_player_board)
    else
      current_board.each do |move|
        cloned_board = clone_board(current_board)
        depth += 1
        possible_player_board = whose_turn_to_check_possible_move(depth) << cloned_board.delete(move)
        minimax_score = minimax(cloned_board, possible_player_board, depth, score)
        #BROKEN RIGHT HERE- DEPTH IS NOT BEING RETURNED AND PASSED TO SCORE_OF_MOVE FOR ACCURATE SCORE
        node_score = score_of_move_based_on_whose_turn_it_is(minimax_score, depth)
        score = node_score if node_score <= score
      end
    end
    score
  end

  def whose_turn_to_check_possible_move(depth)
    moves_played_elements = @moves_played.dup
    opponent_played_elements = @opponent_moves_played.dup
    depth.even? ? moves_played_elements : opponent_played_elements
  end

  def score_board_state(player_board, depth = 0)
    winner?(player_board) ? 10.0 : 0.0
  end

  def game_over?(board_state, player_moves = [])
    tie?(board_state) || winner?(player_moves) 
  end

  def tie?(board_state)
    board_state.empty?
  end

  def winner? board_state
    @rules.winner?(board_state, @rules.winning_combos)
  end

  def score_of_move_based_on_whose_turn_it_is(score, depth)
    return 0.0 if score_is_zero?(score)
    depth.odd? ? -score : (score)
  end

  def score_is_zero?(score)
    score == 0
  end

  def clone_board(board)
    board.clone
  end

end
