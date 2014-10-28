class BoardIO

  def customize_board_or_choose_opponent(output_stream = $stdout)
    output_stream.puts "Would you like to customize your board size?\n    TicTacToe is 3x3 by default\n    Enter C to customize the board size.\n    Enter anything else to choose your opponent."
  end

  def board_size_height(output_stream = $stdout)
    output_stream.puts "How tall would you like the board to be?"
  end

  def board_size_width(output_stream = $stdout)
    output_stream.puts "How wide would you like the board to be?\nNote: TicTacToe was really meant to be a square, but whatever."
  end

  def player_symbol(output_stream = $stdout)
    output_stream.puts "X vs. O can be a little predictable. Would you like to pick a different symbol for your opponent?"
  end

  def choose_opponent(output_stream = $stdout)
    output_stream.puts "Please choose your opponent:\n   Enter 1 for easy computer\n   Enter 2 for hard computer\n   Enter 3 to play against your friend who is sitting next to you."
  end

  def self.move_choice(move, output_stream = $stdout)
    output_stream.puts "Move choice for this turn: #{move}\n"
  end

  def already_taken(output_stream = $stdout)
    output_stream.puts "Oops. Can't do that. Please choose one of the spaces that is available on the board."
  end

  def forfeit(output_stream = $stdout)
    output_stream.puts "You are really not ready for this game. Come back when you are serious."
  end

  def user_input(input_stream = $stdin)
    input_stream.gets.chomp
  end

end
