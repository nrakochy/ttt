class GameRules

  attr_reader :winning_combos, :rules, :player1_symbol, :player2_symbol, :board

  def initialize(board, winning_combos = [], player1_symbol = 'X', player2_symbol = 'O')
    @board = board
    @board_size = board.find_board_size
    @height = @board_size
    @width = @board_size
    @player1_symbol = player1_symbol
    @player2_symbol = player2_symbol
    @winning_combos = find_winning_combinations
  end

  def winner?(player_moves)
    player_combos = player_moves.combination(@board_size).to_a
    got_a_winner = false
    player_combos.each{|arr| got_a_winner = true if got_a_winner?(arr)}
    got_a_winner
  end

  def find_winning_combinations
    winners = []
    winners = find_winning_columns +
      find_winning_rows <<
      find_winning_left_diagonal <<
      find_winning_right_diagonal
    @winning_combos = winners
  end

  def find_winning_columns
    winning_columns = []
    columns = 0.upto(@width-1).to_a
    col_arr = []
    columns.map do |column|
      while  col_arr.length < @height
        col_arr << column
        column += @width
      end
      winning_columns << col_arr
      col_arr = []
    end
    winning_columns
  end

  def find_winning_rows
    board_size = @height * @width
    board = (0..board_size-1).to_a
    winning_rows = []
    while board.length > 0
      winning_rows << board.take(@width)
      board = board.drop(@width)
    end
    winning_rows
  end

  def find_winning_left_diagonal
    winning_diagonal = []
    corner = 0
    while winning_diagonal.length < @height
      winning_diagonal << corner
      corner += (@width + 1)
    end
    winning_diagonal
  end

  def find_winning_right_diagonal
    winning_diagonal = []
    corner = @width - 1
    while winning_diagonal.length < @height
      winning_diagonal << corner
      corner += (@width - 1)
    end
    winning_diagonal
  end

  def find_player_moves_by_indices(player_symbol)
    player_moves = []
    @board.get_the_game_board.each_with_index{ |space, index| player_moves << index if space == player_symbol }
    player_moves
  end

  def got_a_winner?(player_combo)
    @winning_combos.include?(player_combo)
  end

  def check_for_win?(player_symbol)
    got_a_winner = false
    move_combos = player_move_combinations(player_symbol)
    return false if move_combos.empty?
    move_combos.each{|combo| got_a_winner = true if got_a_winner?(combo) }
    got_a_winner
  end

  def tie?
    @board.find_open_spaces.empty? && !winner_on_the_board?
  end

  def winner_on_the_board?
    check_for_win?(@player1_symbol) || check_for_win?(@player2_symbol)
  end

  private

  def player_move_combinations(player_symbol)
    moves_to_check = find_player_moves_by_indices(player_symbol)
    moves_to_check.permutation(@board_size).to_a
  end


end
