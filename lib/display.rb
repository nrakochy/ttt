require_relative 'visual_rep'
class Display

  def empty_board height = 3, width = 3
    board_size = height * width
    x = 0
    space = []
    while x < board_size
      space[x] = VisualRep.new(x+1)
      x += 1
    end
    space
  end
  
  def modified_board player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O'
    board = empty_board
    player1_moves.each{|move| board[move - 1].visual_symbol = player1_symbol}
    player2_moves.each{|move| board[move - 1].visual_symbol = player2_symbol}
    board
  end

  def non_terminating_row_space_less_than_ten_width spaces, index
    "  " + "#{spaces[index].visual_symbol} " + "  " 
  end

  def terminating_row_space_less_than_ten_width spaces, index
    "  " + "#{spaces[index].visual_symbol} " + "  " 
  end

  def non_terminating_row_space_more_than_ten_width spaces, index
     "  " + "#{spaces[index].visual_symbol}" + "  " 
  end

  def terminating_row_space_more_than_ten_width spaces, index
     "  " + "#{spaces[index].visual_symbol}" + "  " 
  end

  def horizontal_line width, display
    display = []
    (width * 7).times{|horizontal| display << "_"}
    return_string(display)
  end

  def new_line
    "\n"
  end

  def vertical_line
    "|"
  end

  def return_string display
    display.inject(""){|sum, string| sum += string}
  end

  def create_display_row width, spaces, index
    display = []
    x = 1 
    (width-1).times do |one_space_at_a_time| 
      if  x < 9
        display << non_terminating_row_space_less_than_ten_width(spaces, index)
        display << vertical_line
        x += 1
      else 
        display << non_terminating_row_space_more_than_ten_width(spaces, index)
        display << vertical_line
      end
    end  
    width < 10 ? display << terminating_row_space_less_than_ten_width(space, index) : display << terminating_row_space_more_than_ten_width(space, index) 
    display << new_line
    return_string(display)
  end

  def visual_board player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O', height = 3, width = 3
    current_board = modified_board(player1_moves, player2_moves, player1_symbol, player2_symbol)
    x = 1
    display = []
    while x < height
      display << create_display_row
      display << horizontal_line
      x += 1
    end
    display << create_display_row
    print return_string(display)
  end
end


