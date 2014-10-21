class Cell 
  attr_accessor :cell_symbol, :cell_string

  def initialize cell_symbol
    @cell_symbol = cell_symbol
    @cell_string 
  end
  
  def define_cell_string length = 3, width = 3, space
    cell = "  #{space[x].cell_symbol}   "
    vertical =  "|"
    horizontal = "_______"
    open_space = "     "
    new_line = "\n"
    
  end

   
  def visual player1_moves = [], player2_moves = [], player1_symbol = 'X', player2_symbol = 'O', height = 3, width = 3
    space = empty_board
    
    # HERE IS WHERE THE CHANGE 
    x = 0
    y = 1
    z = 0
    cell = "  #{space[x].cell_symbol}   "
    vertical =  "|"
    horizontal = "_______"
    open_space = "     "
    new_line = "\n"
    
    display = []
    while y <= height 
      while x < ((height * y) - 1)
        display << cell 
        display << vertical
        x += 1
      end
      display << cell
      display << new_line
      x = y - 1 
      while x < (height * y)
        display << open_space  
        display << vertical
        x += 1
      end
      
      
      
      
      if x < ((height*width) - height)
        display << horizontal
        y += 1
        x = y - 1
      else 
        y += 1
        x = y-1
      end
    end
    
    
    
    
    string = nil  
    while z < display.length
      string ||= display[z]
      string += display[z]
      z += 1
      string
    end
    puts string

  end 
    
end
