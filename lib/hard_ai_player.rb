class HardAIPlayer
  attr_reader :player1_symbol, :player2_symbol, :current_board, :player_symbol

  def initialize(current_board, player1_symbol = 'X', player2_symbol = 'O', player_symbol = 'O')
    @player1_symbol = player1_symbol
    @player2_symbol = player2_symbol
    @current_board =  current_board
    @player_symbol = player_symbol
  end

  def make_move board
    scores = create_score_for_each_available_move(board)
    get_next_best_move(scores)
  end

  def get_next_best_move scores_hash
    scores_hash.max_by{|space, value| value}[0]
  end

  def create_score_for_each_available_move(board, scores = {})
    @current_board = board
    current_board.open_spaces.each do |move|
      current_board.apply_move_to_board(move, player2_symbol)
      scores[move] = -negamax(current_board)
      current_board.undo_move(move)
    end
    scores
  end

  def score_board_state(depth)
    if winner?(player2_symbol) && depth == 0
      1
    elsif winner?(player2_symbol) || loser?
     -1
    else
      0.0
    end
  end

  def game_over?
    tie? || winner?(player2_symbol) || loser?
  end

  def tie?
    current_board.tie?
  end

  def loser?
    winner?(player1_symbol)
  end

  def winner? symbol_of_either_player
    current_board.check_for_win?(symbol_of_either_player)
  end

  private

  def negamax(board, depth = 0, player_turn = 1)
    return score_board_state(depth) if game_over?
    score = -9999
    board.open_spaces.each do |move|
      if board.open_spaces.count.even?
        board.apply_move_to_board(move, player2_symbol)
      else
        board.apply_move_to_board(move, player1_symbol)
      end
      score = [score, -negamax(board, depth + 1)].max
      board.undo_move(move)
    end
    score
  end


end
