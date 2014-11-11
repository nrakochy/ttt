require 'pry'
class HardAIPlayer
  attr_reader :player_symbol
  
  def initialize(game_rules, current_board, player_symbol = 'O')
    @rules = game_rules
    @player_symbol = player_symbol
    @current_board = current_board
  end

  def make_move current_board
    copy_board = clone_board(@current_board)
  end

  def create_scores_for_each_available_move(copied_board, scores = {})
    copied_board.available_spaces.each{|move| scores[move] = negamax(copied_board) }
    scores
  end

  def negamax(board, depth= 1, player_turn = 1)
    score = -999
    if game_over?(board)
      return score_board_state(board, player_turn)
    else
      board.available_spaces.each do |move|
        if depth.odd?
          board.apply_move_to_board(move, board.player2_already_played)
        else
          board.apply_move_to_board(move, board.player1_already_played)
        end
        negamax_result = -negamax(board, depth + 1, -player_turn)
        score = [score, negamax_result].max
        depth = 1
        board = @current_board
      end
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
  
  def clone_board board
    board.clone
  end

end
