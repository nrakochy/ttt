require_relative 'cell'
class Display

  
  def empty_board board_size = 9
    x = 0
    space = []
    while x < board_size
      space[x] = Cell.new(x+1)
      x += 1
    end
    space
  end

  def visual_board player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O'
    space = empty_board
    player1_moves.each{|move| space[move - 1].cell_symbol = player1_symbol}
    player2_moves.each{|move| space[move - 1].cell_symbol = player2_symbol}
    puts "  #{space[0].cell_symbol}  |  #{space[1].cell_symbol}  |  #{space[2].cell_symbol}  \n_____|_____|_____\n  #{space[3].cell_symbol}  |  #{space[4].cell_symbol}  |  #{space[5].cell_symbol}  \n_____|_____|_____\n  #{space[6].cell_symbol}  |  #{space[7].cell_symbol}  |  #{space[8].cell_symbol}  \n     |     |\n     "
  end
  
end


