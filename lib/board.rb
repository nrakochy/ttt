class Board
  include Math
  attr_reader :board_size, :game_board, :open_spaces, :move_count

  def initialize(board_size = 3)
    @board_size = board_size
    @game_board = (1..(board_size*board_size)).to_a
    @open_spaces = find_open_spaces
    @move_count = 0
  end

  def find_board_size
    @board_size
  end

  def get_the_game_board
    @game_board
  end

  def apply_move_to_board(player_move, player_whose_turn_to_play)
    @game_board[player_move-1] = player_whose_turn_to_play
    find_open_spaces
    find_move_count
  end

  def valid_move?(move)
    @open_spaces.include?(move)
  end

  def undo_move(player_move)
    @game_board[player_move - 1] = player_move
    find_open_spaces
    find_move_count
  end

  def find_open_spaces
    open = []
    @game_board.each{|space| open << space if space.class == Fixnum }
    @open_spaces = open
  end

  def find_move_count
    @move_count = @game_board.count - @open_spaces.count
  end

  def preload_game_board_spaces input
    @game_board = input
    find_open_spaces
    find_move_count
    self
  end

end
