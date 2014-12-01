require 'pry'
class HardAIPlayer
  attr_reader :opponent_symbol, :player_symbol, :current_board, :game_rules

  WINNER_ON_THE_BOARD_SCORE = -1.0
  NO_WINNER_ON_THE_BOARD_TIE = 0.0
  ALPHA_NEGATIVE = -999
  BETA_POSITIVE = 999

  def initialize(game_rules)
    @game_rules = game_rules
    @opponent_symbol = game_rules.player1_symbol
    @player_symbol = game_rules.player2_symbol
    @current_board =  game_rules.board
  end

  def make_move
    scores = create_pruned_score_for_each_available_move
    get_next_best_move(scores)
  end

  def get_next_best_move scores_hash
    scores_hash.max_by{|space, value| value}[0]
  end

  def create_score_for_each_available_move(scores = {})
    @current_board.find_open_spaces.each do |move|
      @current_board.apply_move_to_board(move, player_symbol)
      scores[move] = -negamax(
        @current_board, depth = 0)
      @current_board.undo_move(move)
    end
    scores
  end

  def create_pruned_score_for_each_available_move(scores = {})
    @current_board.find_open_spaces.each do |move|
      @current_board.apply_move_to_board(move, player_symbol)
      scores[move] = -negamax_with_alpha_beta_pruning(
        @current_board, ALPHA_NEGATIVE, BETA_POSITIVE)
      @current_board.undo_move(move)
    end
    scores
  end

  def score_board_state
   winner_on_the_board? ? WINNER_ON_THE_BOARD_SCORE : NO_WINNER_ON_THE_BOARD_TIE
  end

  def game_over?
    tie? || winner_on_the_board?
  end

  def tie?
    @game_rules.tie?
  end

  def winner_on_the_board?
    @game_rules.winner_on_the_board?
  end

  def winner?(symbol_of_either_player)
    @game_rules.check_for_win?(symbol_of_either_player)
  end

  def loser?
    winner?(@opponent_symbol)
  end

  private

  def negamax(board, depth = 0)
    return score_board_state(depth) if game_over?
    score = -99999
    board.open_spaces.each do |move|
      if board.open_spaces.count.even?
        board.apply_move_to_board(move, player_symbol)
      else
        board.apply_move_to_board(move, opponent_symbol)
      end
      score = [score, -negamax(board, depth + 1)].max
      board.undo_move(move)
    end
    score
  end

  def negamax_with_alpha_beta_pruning(board, alpha, beta)
    return score_board_state if game_over?
    score = ALPHA_NEGATIVE
    board.open_spaces.each do |move|
      if board.open_spaces.count.even?
        board.apply_move_to_board(move, player_symbol)
      else
        board.apply_move_to_board(move, opponent_symbol)
      end
      score = [score, -negamax_with_alpha_beta_pruning(board, -beta, -alpha)].max
      board.undo_move(move)
      alpha = score if score > alpha
      break if alpha >= beta
    end
    alpha
  end



end
