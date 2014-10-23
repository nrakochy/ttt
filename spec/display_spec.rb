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
    context '3x3 board' do
      xit 'returns a 3x3 board filled with integers as visual represenatation of board spaces' do
        board = Display.new.visual_board
        expect(board).to eq('')
      end
    end
  end

  describe 'Individual board space builder methods' do
    context 'Board width < 10' do
      it 'returns a representative space that is not at the end of a row' do 
        space1 = VisualRep.new(1)
        visual = "  1   "
        expect(Display.new.non_terminating_row_space_less_than_ten_width([space1],0)).to eq(visual)
      end
    end

    context 'Board width >= 10' do
      it 'returns a representative space that is not at the end of a row' do 
        space10 = VisualRep.new(10)
        visual =  '  10  '
        expect(Display.new.non_terminating_row_space_more_than_ten_width([space10], 0)).to eq(visual)
      end
    end
    context 'Board size agnostic' do
      it '#vertical_line returns a vertical line break in between a space' do
        vertical = '|'
        expect(Display.new.vertical_line).to eq(vertical)
      end

      it '#return_string returns a string of space components from an array ' do
        arr = ['h', 'e', 'l', 'l', 'o']
        expect(Display.new.return_string(arr)).to eq('hello')
      end

      xit '#create_display_row returns a row of TTT board' do
      end
    end
  end

end
