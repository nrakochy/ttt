require_relative 'board'
require_relative 'game_config'
require_relative 'display'
require_relative 'human_player'
require_relative 'easy_ai_player'
require_relative 'output'
require_relative 'board_setup'
require_relative 'get_input'
require 'pry'

class Main

  def play_ttt
    player1 = HumanPlayer.new("X")
    mode_choice = customize_else_3_in_a_row
      if mode_choice  == 'CUSTOMIZE'
        height = GameConfig.choose_board_size_height
        width = GameConfig.choose_board_size_width
        board_setup = BoardSetup.new.new_board(height, width)
        winning_combos = BoardSetup.new.find_winning_combinations(height, width)
      else 
        board_setup = BoardSetup.new.new_board
        winning_combos = BoardSetup.new.find_winning_combinations
        height = 3
        width = 3
      end

    opponent = GameConfig.new.choose_opponent
    binding.pry
      if opponent == "E"
        player2 = EasyAIPlayer.new('O')
      elsif opponent == "H"
        player2 = HardAIPlayer.new('O')
      else 
        player2 = HumanPlayer.new('O')
      end
    spaces_available = board_setup.length
    board = Board.new(winning_combos, board_setup)
    print Display.new.visual_board(player1.moves_played, player2.moves_played, height, width, player1.player_symbol, player2.player_symbol)
    move_count = 0
    winner = false
    while move_count < spaces_available && winner == false
      current_board ||= board
      player1_turn?(move_count) ? player = player1 : player = player2 
      move = player.make_move(current_board.board_spaces)
      Output.move_choice(move)
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
    Output.new.customize_board_or_choose_opponent
    input = GetInput.new.user_input
    input == 'C' ? 'CUSTOMIZE' : input
  end 

end

Main.new.play_ttt
