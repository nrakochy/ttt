class GameRules
  attr_reader :winning_combos

  def initialize winning_combos = [] 
  end

  def winner? player_moves, winning_combos, board_size = 3
    player_combos = player_moves.combination(board_size).to_a
    got_a_winner = false 
    player_combos.each{|arr| got_a_winner = true if winning_combos.include?(arr)}
    got_a_winner
  end 
  
  def loser? player_moves, board_size
    winner?(player_moves, board_size)
  end

  def find_winning_combinations(height = 3, width = 3)
    winners = [] 
    winners = find_winning_columns(height, width) + find_winning_rows(height, width) << find_winning_left_diagonal(height, width) <<  find_winning_right_diagonal(height, width)
    @winning_combos = winners
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
    board_size = height * width
    board = (1..board_size).to_a
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
