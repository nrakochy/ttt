require_relative '../lib/display'

describe Display do
  describe '#empty board' do
    context '3x3 board' do
      it 'creates a 3x3 board by default' do
        expect(Display.new.empty_board.length).to eq(9)
      end
      
      it 'returns an Array' do
        expect(Display.new.empty_board.class).to eq(Array)
      end

      it 'returns an array of VisualRep objects' do
        board = Display.new.empty_board
        expect(board[0].class).to eq(VisualRep)
      end
    end

    context 'various board sizes' do
      it 'returns a board that is able to take a 4x4 square' do
        expect(Display.new.empty_board(4,4).length).to eq(16)
      end

      it 'returns a 2x6 board that is not square' do
        expect(Display.new.empty_board(2,6).length).to eq(12)
      end
    end
  end

  describe '#modified_board' do
    context 'Board size agnostic' do
      xit 'returns an unchanged board by default if no player_moves passed in' do
        board = Display.new.empty_board
        expect(Display.new.modified_board).to eq(board)
      end

      it 'changes VisualRep.visual_symbol from integer to player_symbol' do
        player_move = [1]
        expect(Display.new.modified_board(player_move).first.visual_symbol).to eq('X')
      end

      it 'changes VisualRep.visual_symbol from integer for two players' do
        player1_moves = [1]
        player2_moves = [2]
        board = Display.new.modified_board(player1_moves, player2_moves)
        expect(board[0].visual_symbol).to eq('X')
        expect(board[1].visual_symbol).to eq('O')
      end
    end
  end

  describe '#visual_board' do
    context 'various board sizes' do
      it 'returns a 3x3 board filled with integers as visual represenatation of board spaces' do
        board = Display.new.visual_board
        board3 =  "  1   |  2   |  3   "  + "\n" +
                  "_____________________" + "\n" +
                  "  4   |  5   |  6   "  + "\n" +
                  "_____________________" + "\n" +
                  "  7   |  8   |  9   "  + "\n" 
        expect(board).to eq(board3)
      end
      it 'returns a 4x4 board filled with integers as visual represenatation of board spaces' do
        player1_moves = []
        player2_moves = []
        width = 4
        height = 4
        board = Display.new.visual_board(player1_moves, player2_moves,height, width)
        board4 =  "  1   |  2   |  3   |  4   "  + "\n" +
                  "____________________________" + "\n" +
                  "  5   |  6   |  7   |  8   "  + "\n" +
                  "____________________________" + "\n" +
                  "  9   |  10  |  11  |  12  "  + "\n" + 
                  "____________________________" + "\n" +
                  "  13  |  14  |  15  |  16  " + "\n" 
        expect(board).to eq(board4)
      end

      it 'returns a 4x4 board filled with integers and Player symbols already played as visual represenatation of board spaces' do
        player1_moves = [10, 11]
        player2_moves = [14, 15]
        width = 4
        height = 4
        board = Display.new.visual_board(player1_moves, player2_moves,height, width)
        board4 =  "  1   |  2   |  3   |  4   "  + "\n" +
                  "____________________________" + "\n" +
                  "  5   |  6   |  7   |  8   "  + "\n" +
                  "____________________________" + "\n" +
                  "  9   |  X   |  X   |  12  "  + "\n" + 
                  "____________________________" + "\n" +
                  "  13  |  O   |  O   |  16  " + "\n" 
        expect(board).to eq(board4)
      end

      it 'returns properly formatted 4x4 board with custom sized player symbols included' do
        player1_moves = [10, 11]
        player2_moves = [14, 15]
        width = 4
        height = 4
        player1_symbol = "&"
        player2_symbol = "~+"
        board = Display.new.visual_board(player1_moves, player2_moves,height, width, player1_symbol, player2_symbol)
        board4 =  "  1   |  2   |  3   |  4   "  + "\n" +
                  "____________________________" + "\n" +
                  "  5   |  6   |  7   |  8   "  + "\n" +
                  "____________________________" + "\n" +
                  "  9   |  &   |  &   |  12  "  + "\n" + 
                  "____________________________" + "\n" +
                  "  13  |  ~+  |  ~+  |  16  " + "\n" 
        expect(board).to eq(board4)
      end

      it 'returns a 5x5 board filled with integers as visual represenatation of board spaces' do
        player1_moves = []
        player2_moves = []
        width = 5
        height = 5
        board = Display.new.visual_board(player1_moves, player2_moves,height, width)
        board5 =  "  1   |  2   |  3   |  4   |  5   "  + "\n" +
                  "___________________________________" + "\n" +
                  "  6   |  7   |  8   |  9   |  10  "  + "\n" +
                  "___________________________________" + "\n" +
                  "  11  |  12  |  13  |  14  |  15  "  + "\n" +
                  "___________________________________" + "\n" +
                  "  16  |  17  |  18  |  19  |  20  " + "\n" +
                  "___________________________________" + "\n" +
                  "  21  |  22  |  23  |  24  |  25  " + "\n"
        expect(board).to eq(board5)
      end

      it 'returns a 2x4 board filled with integers as visual represenatation of board spaces' do
        player1_moves = []
        player2_moves = []
        width = 4
        height = 2
        board = Display.new.visual_board(player1_moves, player2_moves,height, width)
        board2x4 =  "  1   |  2   |  3   |  4   "  + "\n" +
                    "____________________________" + "\n" +
                    "  5   |  6   |  7   |  8   "  + "\n"
        expect(board).to eq(board2x4)
      end



    end
  end

  describe 'Individual board space builder methods' do
    context 'Board width < 10' do
      it '#non_terminating_row_space_less_than_ten_width returns a representative space that is not at the end of a row' do 
        space1 = VisualRep.new(1)
        visual = "  1   |"
        expect(Display.new.non_terminating_row_space_less_than_ten_width(space1)).to eq(visual)
      end

      it '#add_non_terminating_row_space returns a representative space when string on VisualRep.visual_symbol is >= 2' do
        spaceX = VisualRep.new("X")
        visual =  '  X   |'
        expect(Display.new.non_terminating_row_space_less_than_ten_width(spaceX)).to eq(visual)
      end

    end

    context 'Board width >= 10' do
      it '#non_terminating_row_space_more_than_ten_width returns a representative space that is not at the end of a row' do 
        space10 = VisualRep.new(10)
        visual =  '  10  |'
        expect(Display.new.non_terminating_row_space_more_than_ten_width(space10 )).to eq(visual)
      end

      it '#add_non_terminating_row_space returns a representative space when string on VisualRep.visual_symbol is >= 2' do
        space10 = VisualRep.new(10)
        visual =  '  10  |'
        expect(Display.new.non_terminating_row_space_more_than_ten_width(space10 )).to eq(visual)
      end

    end

    context 'Board size agnostic' do
      it '#return_string returns a string of space components from an array ' do
        arr = ['h', 'e', 'l', 'l', 'o']
        expect(Display.new.return_string(arr)).to eq('hello')
      end

      it '#horizontal_line returns a horizontal line that is the width of a single space * the width of the board + width-1 (for the number of vertical lines) ' do
        board_width = 3
        line = "_____________________\n"
        expect(Display.new.horizontal_line(board_width)).to eq(line)
      end

      it '#row_builder returns an array with width number of elements' do
        board = [1,2,3,4,5,6]
        width = 3
        expect(Display.new.row_builder(board, width)).to eq([1,2,3])
      end
    end
  end

  describe '#create_display_row' do
    context 'Board size agnostic' do
      it 'returns a string-row of TTT board' do
        board_spaces= [1,2,3]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  1   |  2   |  3   \n"
        expect(Display.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that does not start with 1' do
        board_spaces = [3,4,5]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  3   |  4   |  5   \n"
        expect(Display.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that contains single and double digit numbers' do
        board_spaces = [9,10,11]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  9   |  10  |  11  \n"
        expect(Display.new.create_display_row(board_spaces)).to eq(board_row)
      end   

      it 'returns a string-row that formats row with only double digit correctly' do
        board_spaces = [10,11,12,13]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  10  |  11  |  12  |  13  \n"
        expect(Display.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that formats double digit and Player symbol correctly' do
        board_spaces = [10,"X",12,13]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  10  |  X   |  12  |  13  \n"
        expect(Display.new.create_display_row(board_spaces)).to eq(board_row)
      end
    end
  end
end
