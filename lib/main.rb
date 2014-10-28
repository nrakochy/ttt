require_relative 'game_config'
require_relative 'game_rules'
require_relative 'display'
require_relative 'human_player'
require_relative 'easy_ai_player'
require_relative 'hard_ai_player'
require_relative 'io'
require_relative 'board'
require 'pry'

class Main

  def play_ttt
    player1 = HumanPlayer.new("X")
    game_config  = GameConfig.new
    board = Board.new
    display = Display.new
    game_rules = GameRules.new

    mode_choice = game_config.customize_else_3_in_a_row
      if mode_choice  == 'CUSTOMIZE'
        height = game_config.choose_board_size_height
        width = game_config.choose_board_size_width
        board_setup = board.new_board(height, width)
        winning_combos = game_rules.find_winning_combinations(height, width)
      else 
        board_setup = board.new_board
        height = 3
        width = 3
        winning_combos = game_rules.find_winning_combinations
      end

    opponent = game_config.choose_opponent
      if opponent == 1
        player2 = EasyAIPlayer.new('O')
      elsif opponent == 2
        player2 = HardAIPlayer.new('O')
      else 
        player2 = HumanPlayer.new('O')
      end
    spaces_available = board_setup.length
    print display.visual_board(player1.moves_played, player2.moves_played, height, width, player1.player_symbol, player2.player_symbol)
    move_count = 0
    winner = false
    while move_count < spaces_available && winner == false
      current_board ||= board
      if player1_turn?(move_count) 
        player = player1 
        opponent = player2
      else 
        player = player2 
        opponent = player1
        end
      move = player.make_move(current_board.board_spaces, player.moves_played, opponent.moves_played)
      BoardIO.move_choice(move)
      move_count += 1
      player.moves_played << move
      current_board.board_spaces.delete(move)
      print Display.new.visual_board(player1.moves_played, player2.moves_played, height, width, player1.player_symbol, player2.player_symbol)
      already_played = played_combos(player.moves_played, width) 
      already_played.each{|combo| winner = true if winner?(combo, winning_combos )}
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

  def customize_else_3_in_a_row
    BoardIO.new.customize_board_or_choose_opponent
    input = BoardIO.new.user_input.upcase
    input == 'C' ? 'CUSTOMIZE' : input
  end 

end

Main.new.play_ttt
