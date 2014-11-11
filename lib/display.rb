require_relative 'visual_rep'
require 'pry'
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
  
  def modified_board player1_moves = [], player2_moves = [], height = 3, width = 3, player1_symbol = 'X', player2_symbol = 'O'
    board = empty_board(height, width)
    player1_moves.each{|move| board[move - 1].visual_symbol = player1_symbol}
    player2_moves.each{|move| board[move - 1].visual_symbol = player2_symbol}
    board
  end

  def non_terminating_row_space_less_than_ten_width space 
    "  " + "#{space.visual_symbol} " + "  " + "|"
  end

  def terminating_row_space_less_than_ten_width space
    "  " + "#{space.visual_symbol} " + "  \n"
  end

  def non_terminating_row_space_more_than_ten_width space
     "  " + "#{space.visual_symbol}" + "  " + "|"
  end

  def terminating_row_space_more_than_ten_width space
     "  " + "#{space.visual_symbol}" + "  \n"
  end

  def add_non_terminating_row_space row_space
    if row_space.visual_symbol.to_s.length <  2
       non_terminating_row_space_less_than_ten_width(row_space)
    else 
        non_terminating_row_space_more_than_ten_width(row_space)
    end
  end

  def add_terminating_row_space row_space
    if row_space.visual_symbol.to_s.length <  2
        terminating_row_space_less_than_ten_width(row_space)
    else 
        terminating_row_space_more_than_ten_width(row_space)
    end
  end

  def horizontal_line width
    display = []
    (width * 7).times{|horizontal| display << "_"}
    display << "\n"
    return_string(display)
  end

  def return_string display
    display.inject(""){|sum, string| sum += string}
  end
  
  def row_builder board, width
    board.slice(0, width)
  end


  def create_display_row row_spaces
    display = []
    last_space = row_spaces.pop
    row_spaces.each{|row_space| display << add_non_terminating_row_space(row_space)}
    display << add_terminating_row_space(last_space)
    return_string(display)
  end

  def visual_board player1_moves = [], player2_moves = [], height = 3, width = 3, player1_symbol = 'X', player2_symbol = 'O'
    display = []
    current_board = modified_board(player1_moves, player2_moves, height, width, player1_symbol, player2_symbol)
    x = 1
    display = []
    while x < height
      row_builder = row_builder(current_board, width)
      current_board -= row_builder
      display << create_display_row(row_builder)
      display << horizontal_line(width)
      x += 1
      current_board
    end
    display << create_display_row(current_board)
    return_string(display)
  end
end


