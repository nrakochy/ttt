class GameRules
  attr_reader :winning_combos, :game_size

  def initialize height = 3, width = 3, board_size = 3
    @winning_combos = find_winning_combinations(height, width)
  end

  def winner? player_moves, winners, board_size = 3
    player_combos = player_moves.combination(board_size).to_a
    got_a_winner = false 
    player_combos.each{|arr| got_a_winner = true if winners.include?(arr)}
    got_a_winner
  end

  def find_winning_combinations(height = 3, width = 3)
    winners = []
    winners = find_winning_columns(height, width) + find_winning_rows(height, width) << find_winning_left_diagonal(height, width) <<  find_winning_right_diagonal(height, width)
    winners
  end
  
  def find_winning_columns(height = 3, width = 3)
    winning_columns = []
    columns = 0.upto(width-1).to_a
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
    board_size = height * width
    board = (0..board_size-1).to_a
    winning_rows = []
    while board.length > 0
      winning_rows << board.take(width)
      board = board.drop(width)
    end
    winning_rows
  end

  def find_winning_left_diagonal(height = 3, width = 3)
    winning_diagonal = []
    corner = 0
    while winning_diagonal.length < height
      winning_diagonal << corner
      corner += (width + 1)
    end
    winning_diagonal
  end

  def find_winning_right_diagonal(height = 3, width = 3)
    winning_diagonal = []
    corner = width - 1
    while winning_diagonal.length < height
      winning_diagonal << corner
      corner += (width - 1)
    end
    winning_diagonal
  end


end
