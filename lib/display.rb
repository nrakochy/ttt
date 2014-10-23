require_relative 'cell'
require 'pry'
class Display

=begin  
  def empty_board board_size = 9
    x = 0
    space = []
    while x < board_size
      space[x] = Cell.new(x+1)
      x += 1
    end
    space
  end

  def visual_board player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O', height = 3, width = 3
    space = empty_board
    player1_moves.each{|move| space[move - 1].cell_symbol = player1_symbol}
    player2_moves.each{|move| space[move - 1].cell_symbol = player2_symbol}

    puts "  #{space[0].cell_symbol}  |  #{space[1].cell_symbol}  |  #{space[2].cell_symbol}  \n_____|_____|_____\n  #{space[3].cell_symbol}  |  #{space[4].cell_symbol}  |  #{space[5].cell_symbol}  \n_____|_____|_____\n  #{space[6].cell_symbol}  |  #{space[7].cell_symbol}  |  #{space[8].cell_symbol}  \n     |     |\n     "
  end
=end

  
  def empty_board height = 3, width = 3
    board_size = height * width
    x = 0
    space = []
    while x < board_size
      space[x] = Cell.new(x+1)
      x += 1
    end
    space
  end
  
  def modified_board board, player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O'
    player1_moves.each{|move| board[move - 1].cell_symbol = player1_symbol}
    player2_moves.each{|move| board[move - 1].cell_symbol = player2_symbol}
    board
  end
    
  
  def visual_board player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O', height = 3, width = 3
    board_size = height * width
    empty_board = empty_board(board_size)
    space = modified_board(empty_board, player1_moves, player2_moves, player1_symbol, player2_symbol)
    x = 0 
    y = 1
    display = []
    while y <= height
      while x <  (width* y)
        if (x + 1) < (width * y) && x < 9
          display <<  "  " + "#{space[x].cell_symbol} " + "  " + "|"
          x += 1
        elsif (x + 1) >= (width * y) && x < 10
          display << "  " + "#{space[x].cell_symbol} " + "  " + "\n"
          x += 1
        elsif (x + 1) < (width * y) && x >= 9
          display <<  "  " + "#{space[x].cell_symbol}" + "  " + "|"
          x += 1
        else
          display << "  " + "#{space[x].cell_symbol}" + "  " + "\n"
          x += 1
        end
      end
      y += 1
      if y <= height
        (width * 7).times{|horizontal| display << "_"}
        display << "\n"
      end
    end
    print display.inject(""){|sum, string| sum += string}
  end
  

  
end


