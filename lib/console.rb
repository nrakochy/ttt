require_relative '../lib/board_io'
class Console

  def initialize io = BoardIO.new
    @io = io
  end

  def customize_board_or_choose_opponent
    @io.print_output("Would you like to customize your board size?\n
        TicTacToe is 3x3 by default\n
        Enter C to customize the board size.\n
        Enter anything else to choose your opponent.")
  end

  def board_size_height
    @io.print_output("How tall would you like the board to be?")
  end

  def board_size_width
    @io.print_output("How wide would you like the board to be?\nNote: TicTacToe was really meant to be a square, but whatever.")
  end

  def player_symbol
    @io.print_output(
      "X vs. O can be a little predictable. 
      Would you like to pick a different symbol for your opponent?")
  end

  def choose_opponent
    @io.print_output("Please choose your opponent:\n
    Enter 1 for easy computer\n
    Enter 2 for hard computer\n
    Enter 3 to play against your friend who is sitting next to you.")
  end

  def move_choice(move)
    @io.print_output("Move choice for this turn: #{move}\n")
  end

  def already_taken
    @io.print_output(
      "Oops. Can't do that. Please choose one of the spaces 
      that is available on the board.")
  end

  def forfeit
    @io.print_output("You are really not ready for this game. 
                     Come back when you are serious.")
  end

  def game_over
    @io.print_output("Game over.")
  end

  def user_input
    @io.get_input.chomp
  end

end
