class BoardSetup

  def new_board (height= 3, width = 3)
    board = []
    board_size = height *= width
    board_size.times{|num| board << (num+1) }
    board
  end
  
  def find_winning_combinations(height = 3, width = 3)
    winning_combos = [] 
    winning_combos = find_winning_columns(height, width) + find_winning_rows(height, width) << find_winning_left_diagonal(height, width) <<  find_winning_right_diagonal(height, width)
    winning_combos
  end
  
  def find_winning_columns(height = 3, width = 3)
    winning_columns = []
    columns = 1.upto(width).to_a
    col_arr = []
    columns.map do |column|
      while  col_arr.length < height
        col_arr << column
        column += width
      end
      winning_columns << col_arr
      col_arr = []
    end
    winning_columns
  end

  def find_winning_rows(height = 3, width = 3)
    board = new_board(height, width)
    winning_rows = []
    while board.length > 0
      winning_rows << board.take(width)
      board = board.drop(width)
    end
    winning_rows
  end

  def find_winning_left_diagonal(height = 3, width = 3)
    winning_diagonal = []
    corner = 1
    while winning_diagonal.length < height
      winning_diagonal << corner
      corner += (width + 1)
    end
    winning_diagonal
  end

  def find_winning_right_diagonal(height = 3, width = 3)
    winning_diagonal = []
    corner = width
    while winning_diagonal.length < height
      winning_diagonal << corner
      corner += (width - 1)
    end
    winning_diagonal
  end

end
