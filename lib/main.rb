require_relative 'game_config'
require_relative 'game_rules'
require_relative 'display'
require_relative 'human_player'
require_relative 'easy_ai_player'
require_relative 'hard_ai_player'
require_relative 'board_io'
require_relative 'board'

require 'pry'

class Main

  def play_ttt
    display = Display.new
    board_io = BoardIO.new
    io = Console.new(board_io)
    game_config  = GameConfig.new(io)

    mode_choice = game_config.customize_else_3_in_a_row
      if mode_choice  == 'CUSTOMIZE'
        height = game_config.choose_board_size_height
        width = height
        board_size = height * width
        board = Board.new.new_board(board_size)
        board_setup = board.available_spaces.length
        game_rules = GameRules.new(height, width)
        board = Board.new(game_rules)
        board.new_board
      else 
        height = 3
        width = 3
        board_size = height * width
        game_rules = GameRules.new(height, width)
        board = Board.new(game_rules)
        board.new_board
        board_setup = board_size
      end

    player1 = HumanPlayer.new(game_rules, board)
    opponent = game_config.choose_opponent
      if opponent == 1
        player2 = EasyAIPlayer.new(game_rules, board)
      elsif opponent == 2
        player2 = HardAIPlayer.new(game_rules, board)
      else 
        player2 = HumanPlayer.new(game_rules, board, 'O')
      end
    print display.visual_board(board, height, width)
    move_count = 0
    winner = false
    while move_count < board_size && winner == false
      current_board ||= board
      if move_count.even?
        player = player1
      else
        player = player2
      end
      move = player.make_move(board)
      io.move_choice(move)
      move_count += 1
      current_board.apply_move_to_board(move, player.player_symbol)
      print display.visual_board(current_board, height, width)
      winner = true if board.check_for_win?(player.player_symbol)
    end
    puts "Game over."
  end

  def winner? player_move, winning_combos
    winning_combos.include?(player_move)
  end
  
  def played_combos(moves_played, width)
    moves_played.permutation(width).to_a
  end

end

Main.new.play_ttt
