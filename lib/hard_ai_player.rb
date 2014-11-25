class HardAIPlayer
  attr_reader :opponent_symbol, :player_symbol, :current_board, :game_rules

  def initialize(game_rules)
    @game_rules = game_rules
    @opponent_symbol = game_rules.player1_symbol
    @player_symbol = game_rules.player2_symbol
    @current_board =  game_rules.board
  end

  def make_move
    scores = create_score_for_each_available_move
    get_next_best_move(scores)
  end

  def get_next_best_move scores_hash
    scores_hash.max_by{|space, value| value}[0]
  end

  def create_score_for_each_available_move(scores = {})
    @current_board.find_open_spaces.each do |move|
      @current_board.apply_move_to_board(move, player_symbol)
      scores[move] = -negamax(@current_board)
      @current_board.undo_move(move)
    end
    scores
  end

  def score_board_state(depth)
    if winner?(player_symbol) && depth == 0
      -1
    elsif winner?(player_symbol) || loser?
     -1
    else
      0.0
    end
  end

  def game_over?
    tie? || @game_rules.winner_on_the_board?
  end

  def tie?
    @game_rules.tie?
  end

  def loser?
    winner?(opponent_symbol)
  end

  def winner? symbol_of_either_player
    @game_rules.check_for_win?(symbol_of_either_player)
  end

  private

  def negamax(board, depth = 0, player_turn = 1)
    return score_board_state(depth) if game_over?
    score = -9999
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

  def negamax_with_alpha_beta_pruning(board, depth, alpha, beta)
    return score_board_state(depth) if game_over?
    board.open_spaces.each do |move|
      if board.open_spaces.count.even?
        board.apply_move_to_board(move, player_symbol)
      else
        board.apply_move_to_board(move, opponent_symbol)
      end
      score = [score, -negamax(board, depth + 1, -beta, -alpha)].max
      board.undo_move(move)
      if score > alpha
        alpha = score
        return -1 if depth == 0
      break if alpha >= beta
      return alpha
      end
    end
  end



end
