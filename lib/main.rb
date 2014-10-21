require_relative 'board'
require_relative 'display'
require_relative 'player'
require_relative 'output'
require_relative 'board_setup'

class Main

  def play_ttt
    setup = BoardSetup.new.new_board
    winning_combos = BoardSetup.new.find_winning_combinations
    player1 = Player.new("X")
    player2 = Player.new("O")
    spaces_available = setup.length
    board = Board.new(winning_combos, setup)
    Display.new.visual_board(player1.moves_played, player2.moves_played, player1.player_symbol, player2.player_symbol)
    move_count = 0
    winner = false
    while move_count < spaces_available && winner == false
      current_board ||= board
      player1_turn?(move_count) ? player = player1 : player = player2 
      move = player.make_move
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

end

Main.new.play_ttt
