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
        width = game_config.choose_board_size_width
        board = Board.new.new_board(height,width)
        board_setup = board.available_spaces.length
        binding.pry
        game_rules = GameRules.new(height, width)
      else 
        board = Board.new
        board_setup = board.available_spaces.length
        height = 3
        width = 3
        game_rules = GameRules.new
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
    spaces_available = board_setup
    print display.visual_board(board.player1_already_played, board.player2_already_played, height, width, player1.player_symbol, player2.player_symbol)
    move_count = 0
    winner = false
    while move_count < spaces_available && winner == false
      current_board ||= board
      if player1_turn?(move_count)  
        player = player1
        player_moves = board.player1_already_played
      else  
        player = player2
        player_moves = board.player2_already_played
      end
      move = player.make_move(current_board)
      io.move_choice(move)
      move_count += 1
      current_board.apply_move_to_board(move, player_moves)
      print display.visual_board(board.player1_already_played, board.player2_already_played, height, width, player1.player_symbol, player2.player_symbol)
      already_played = played_combos(player_moves, width) 
      already_played.each{|combo| winner = true if winner?(combo, game_rules.winning_combos)}
      current_board
    end
    puts "Game over."
  end


  def player1_turn? move_count
    move_count.even?
  end

  def winner? player_move, winning_combos
    winning_combos.include?(player_move)
  end
  
  def played_combos(moves_played, width)
    moves_played.permutation(width).to_a
  end

end

Main.new.play_ttt
