require_relative 'game_config'
require_relative 'game_rules'
require_relative 'console_board_presenter'
require_relative 'human_player'
require_relative 'easy_ai_player'
require_relative 'hard_ai_player'
require_relative 'board_io'
require_relative 'board'

class Game

  def setup_and_play_ttt
    io = initialize_io_setup
    game_rules = setup_game_logic_with_board(io)
    player1 = HumanPlayer.new(game_rules)
    player2 = choose_opponent(io, game_rules)
    play_ttt(game_rules, player1, player2, io)
    io.game_over
  end

  def play_ttt(game_rules, player1, player2, io)
    move_count = 0
    winner = false
    board = game_rules.board
    present_board_to_console(board)
    num_spaces_on_the_board = board.get_the_game_board.count
    while move_count < num_spaces_on_the_board && winner == false
      move_count.even? ? player = player1 : player = player2
      move = player.make_move
      io.move_choice(move)
      board.apply_move_to_board(move, player.player_symbol)
      present_board_to_console(board)
      move_count = game_rules.board.find_move_count
      winner = true if game_rules.check_for_win?(player.player_symbol)
    end
  end

  def present_board_to_console(board)
    board_spaces = board.get_the_game_board
    height = board.board_size
    width = board.board_size
    print ConsoleBoardPresenter.new.display_board(board_spaces, height, width)
  end

  def initialize_io_setup
    Console.new(BoardIO.new)
  end

  def setup_game_logic_with_board(io)
    game_config = GameConfig.new(io)
    mode_choice = game_config.customize_else_3_in_a_row
    setup_board_and_rules_with_mode_choice(mode_choice)
  end


  def choose_opponent(io, game_rules)
   opponent = GameConfig.new(io).choose_opponent
    if opponent == 1
      EasyAIPlayer.new(game_rules)
    elsif opponent == 2
      HardAIPlayer.new(game_rules)
    else
      HumanPlayer.new(game_rules)
    end
  end

  def setup_board_and_rules_with_mode_choice(mode_choice)
    if mode_choice  == 'CUSTOMIZE'
      board_size = game_config.choose_board_size_height
      board = Board.new(board_size)
      game_rules = GameRules.new(board)
    else
      board = Board.new
      game_rules = GameRules.new(board)
    end
    game_rules
  end
end

