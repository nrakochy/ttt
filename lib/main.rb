require_relative 'board'
require_relative 'game_config'
require_relative 'display'
require_relative 'human_player'
require_relative 'easy_ai_player'
require_relative 'output'
require_relative 'board_setup'

class Main

  def play_ttt
    player1 = HumanPlayer.new("X")
    mode_choice = customize_else_3_in_a_row
      if mode_choice  == 'CUSTOMIZE'
        height_width_dimensions = GameConfig.new.choose_board_size
        board_setup = BoardSetup.new.new_board(height_width_dimensions[0], height_width_dimensions[1])
        winning_combos = BoardSetup.new.find_winning_combinations(dimensions[0], dimensions[1])
      else 
        board_setup = BoardSetup.new.new_board
        winning_combos = BoardSetup.new.find_winning_combinations
      end

    opponent = GameConfig.new.choose_opponent
      if opponent == "E"
        player2 = EasyAIPlayer.new('O')
      elsif opponent == "H"
        player2 = HardAIPlayer.new('O')
      else 
        player2 = HumanPlayer.new('O')
      end
    spaces_available = board_setup.length
    board = Board.new(winning_combos, board_setup)
    Display.new.visual_board(player1.moves_played, player2.moves_played, player1.player_symbol, player2.player_symbol)
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
      Display.new.visual_board(player1.moves_played, player2.moves_played, player1.player_symbol, player2.player_symbol)
      already_played = played_combos(player.moves_played) 
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

  def played_combos moves_played
    moves_played.permutation(3).to_a
  end

  def customize_else_3_in_a_row
    Output.customize_board_or_choose_opponent
    input = gets.chomp.upcase
    input == 'C' ? 'CUSTOMIZE' : input
  end 

end

Main.new.play_ttt
