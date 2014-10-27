require 'board'

class BoardPlay 
  include Board
  
  attr_reader :winner, :board_spaces

  def initialize winning_combos, current_board_state
    @winner = winning_combos
    @board_spaces = current_board_state
  end



  

end
