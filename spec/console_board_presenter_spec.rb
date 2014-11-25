require_relative '../lib/console_board_presenter'
require_relative '../lib/board'

describe ConsoleBoardPresenter do
  let(:board3x3){ (1..9).to_a }
  let(:board4x4){ (1..16).to_a }
  let(:display3_board){ ConsoleBoardPresenter.new.board_to_display(board3x3) }
  let(:display4_board){ ConsoleBoardPresenter.new.board_to_display(board4x4) }

  describe '#board_to_display ' do
    context '3x3 board' do
      it 'creates a 3x3 board by default' do
        expect(display3_board.length).to eq(9)
      end
      
      it 'returns an Array' do
        expect(display3_board.class).to eq(Array)
      end

      it 'returns an array of VisualRep objects' do
        expect(display3_board[0].class).to eq(VisualRep)
      end
    end

    context '4x4 board' do
      it 'returns a board that is able to take a 4x4 square' do
        expect(display4_board.length).to eq(16)
      end
    end
  end

  describe '#display_board' do
    context 'various board sizes' do
      it 'returns a 3x3 board filled with integers as visual represenatation of board spaces' do
        board = ConsoleBoardPresenter.new.display_board(board3x3, 3, 3)
        board3 =  "  1   |  2   |  3   "  + "\n" +
                  "_____________________" + "\n" +
                  "  4   |  5   |  6   "  + "\n" +
                  "_____________________" + "\n" +
                  "  7   |  8   |  9   "  + "\n" 
        expect(board).to eq(board3)
      end
      it 'returns a 4x4 board filled with integers as visual represenatation of board spaces' do
        board = ConsoleBoardPresenter.new.display_board(board4x4, 4, 4)
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
        new_board = (1..9).to_a + ['X'] + ['X'] + (12..14).to_a + ['O'] + ['O']
        board = ConsoleBoardPresenter.new.display_board(new_board, 4, 4)
        board4 =  "  1   |  2   |  3   |  4   "  + "\n" +
                  "____________________________" + "\n" +
                  "  5   |  6   |  7   |  8   "  + "\n" +
                  "____________________________" + "\n" +
                  "  9   |  X   |  X   |  12  "  + "\n" +
                  "____________________________" + "\n" +
                  "  13  |  14  |  O   |  O   "  + "\n"
        expect(board).to eq(board4)
      end

      it 'returns properly formatted 4x4 board with custom sized player symbols included' do
        board_spaces = (1..9).to_a + ["&", "&"] + (12..13).to_a + ["~+", "~+"] + ['16']
        board = ConsoleBoardPresenter.new.display_board(board_spaces, 4, 4)
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
        board_spaces = (1..25).to_a
        board = ConsoleBoardPresenter.new.display_board(board_spaces, 5, 5)
        board5 =  "  1   |  2   |  3   |  4   |  5   "  + "\n" +
                  "___________________________________" + "\n" +
                  "  6   |  7   |  8   |  9   |  10  "  + "\n" +
                  "___________________________________" + "\n" +
                  "  11  |  12  |  13  |  14  |  15  "  + "\n" +
                  "___________________________________" + "\n" +
                  "  16  |  17  |  18  |  19  |  20  "  + "\n" +
                  "___________________________________" + "\n" +
                  "  21  |  22  |  23  |  24  |  25  "  + "\n"
        expect(board).to eq(board5)
      end
    end
  end

  describe 'Individual board space builder methods' do
    context 'Board width < 10' do
      it '#non_terminating_row_space_less_than_ten_width returns a representative space that is not at the end of a row' do 
        space1 = VisualRep.new(1)
        visual = "  1   |"
        expect(ConsoleBoardPresenter.new.non_terminating_row_space_less_than_ten_width(space1)).to eq(visual)
      end

      it '#add_non_terminating_row_space returns a representative space when string on VisualRep.visual_symbol is >= 2' do
        spaceX = VisualRep.new("X")
        visual =  '  X   |'
        expect(ConsoleBoardPresenter.new.non_terminating_row_space_less_than_ten_width(spaceX)).to eq(visual)
      end

    end

    context 'Board width >= 10' do
      it '#non_terminating_row_space_more_than_ten_width returns a representative space that is not at the end of a row' do 
        space10 = VisualRep.new(10)
        visual =  '  10  |'
        expect(ConsoleBoardPresenter.new.non_terminating_row_space_more_than_ten_width(space10 )).to eq(visual)
      end

      it '#add_non_terminating_row_space returns a representative space when string on VisualRep.visual_symbol is >= 2' do
        space10 = VisualRep.new(10)
        visual =  '  10  |'
        expect(ConsoleBoardPresenter.new.non_terminating_row_space_more_than_ten_width(space10 )).to eq(visual)
      end

    end

    context 'Board size agnostic' do
      it '#return_string returns a string of space components from an array ' do
        arr = ['h', 'e', 'l', 'l', 'o']
        expect(ConsoleBoardPresenter.new.return_string(arr)).to eq('hello')
      end

      it '#horizontal_line returns a horizontal line that is the width of a single space * the width of the board + width-1 (for the number of vertical lines) ' do
        board_width = 3
        line = "_____________________\n"
        expect(ConsoleBoardPresenter.new.horizontal_line(board_width)).to eq(line)
      end

      it '#row_builder returns an array with width number of elements' do
        board = [1,2,3,4,5,6]
        width = 3
        expect(ConsoleBoardPresenter.new.row_builder(board, width)).to eq([1,2,3])
      end
    end
  end

  describe '#create_display_row' do
    context 'Board size agnostic' do
      it 'returns a string-row of TTT board' do
        board_spaces= [1,2,3]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  1   |  2   |  3   \n"
        expect(ConsoleBoardPresenter.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that does not start with 1' do
        board_spaces = [3,4,5]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  3   |  4   |  5   \n"
        expect(ConsoleBoardPresenter.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that contains single and double digit numbers' do
        board_spaces = [9,10,11]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  9   |  10  |  11  \n"
        expect(ConsoleBoardPresenter.new.create_display_row(board_spaces)).to eq(board_row)
      end   

      it 'returns a string-row that formats row with only double digit correctly' do
        board_spaces = [10,11,12,13]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  10  |  11  |  12  |  13  \n"
        expect(ConsoleBoardPresenter.new.create_display_row(board_spaces)).to eq(board_row)
      end

      it 'returns a string-row that formats double digit and Player symbol correctly' do
        board_spaces = [10,"X",12,13]
        board_spaces.map!{|num| VisualRep.new(num)}
        board_row = "  10  |  X   |  12  |  13  \n"
        expect(ConsoleBoardPresenter.new.create_display_row(board_spaces)).to eq(board_row)
      end
    end
  end
end
