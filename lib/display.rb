require_relative 'visual_rep'
class Display

  def board_to_display(board_spaces)
    visual_board = []
    board_spaces.each_with_index{ |space, index| visual_board[index] = VisualRep.new(space) }
    visual_board
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

  def visual_board board_spaces, height = 3, width = 3
    display = []
    current_board = board_to_display(board_spaces)
    x = 1
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


