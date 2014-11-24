An implementation of Tic Tac Toe in Ruby with Negamax in the HardAI Player

To run -
    ruby lib/main.rb once you have all of the files

To-Do

Separate the GameRules from the Board --
	Board needs no knowledge of the rules
	  - only need to initialize board size
	  - Board essentially needs to make moves and undo moves
	
Clean-up default parameters on methods
	Update rspec let statements
	Refactor with instance variables if necessary

Negamax
	Clean up duplicate player symbols
	def create_score_for_each_available_move
		eliminate -scores default arg
		 current_board will keep the state throughout the game-- eliminate passing the board to make move
		 change direct referece to board's attributes - use find_open_spaces
