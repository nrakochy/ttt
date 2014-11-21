class Board
  include Math
  attr_reader :game_rules, :game_board, :board_size, :player1_symbol, :player2_symbol, :move_count, :open_spaces

  def initialize game_rules = [], board_size = 9, game_board = (1..9).to_a, player1_symbol = 'X', player2_symbol = 'O', open_spaces = []
    @rules = game_rules
    @game_board = game_board
    @board_size = board_size
    @winning_combos = game_rules.winning_combos
    @move_count = 0
    @player1_symbol = player1_symbol
    @player2_symbol = player2_symbol
    @open_spaces = find_open_spaces
  end

  def new_board
    board = []
    board_size.times{|num| board << (num+1) }
    @game_board = board
    self
  end

  def apply_move_to_board(player_move, player_whose_turn_to_play)
    @game_board[player_move-1] = player_whose_turn_to_play
    @move_count += 1
    find_open_spaces
  end

  def valid_move? move
    @game_board.include?(move)
  end

  def undo_move(player_move)
    @game_board[player_move - 1] = player_move
    @move_count -= 1
    find_open_spaces
  end

  def find_player_moves_indices(player_symbol)
    player_moves = []
    @game_board.each_with_index{ |space, index| player_moves << index if space == player_symbol }
    player_moves
  end

  def player_move_combinations(player_symbol, winners_length = Math.sqrt(board_size))
    moves_to_check = find_player_moves_indices(player_symbol)
    moves_to_check.permutation(winners_length).to_a
  end

  def winner? player_combo
    @winning_combos.include?(player_combo)
  end

  def check_for_win? player_symbol
    got_a_winner = false
    move_combos = player_move_combinations(player_symbol)
    return false if move_combos.empty?
    move_combos.each{|combo| got_a_winner = true if winner?(combo) }
    got_a_winner
  end

  def tie?
    open_spaces.empty?
  end

  def find_open_spaces
    open = []
    @game_board.each{|space| open << space if space.class == Fixnum }
    @open_spaces = open
  end


  def test_method_game_board input
    @game_board = input
  end



end
