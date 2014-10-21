require_relative '../lib/board_setup'

describe BoardSetup do 

  describe ".new_board" do
    it 'creates a board with 1..9 array by default for 3-in-a-row' do 
      expect(BoardSetup.new.new_board).to eq([1,2,3,4,5,6,7,8,9])
    end
  
    it 'creates a board for 4-in-a-row' do 
      expect(BoardSetup.new.new_board(4, 4)).to eq([1,2,3,4,5,6,7,8,9, 10, 11, 12, 13, 14, 15, 16])
    end
  end

  describe '.find_winning_columns' do
    it 'identifies the columns with winning combinations for 3-in-a-row by default' do
      expect(BoardSetup.new.find_winning_columns).to eq([[1,4,7], [2,5,8], [3,6,9]])
    end

    it 'identifies the columns with winning combinations for 4-in-a-row' do
      expect(BoardSetup.new.find_winning_columns(4,4)).to eq([[1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16]])
    end
  end

  describe '.find_winning_rows' do
    it 'identifies the rows with winning combinations for 3-in-a-row by default' do
      expect(BoardSetup.new.find_winning_rows).to eq([[1,2,3], [4,5,6], [7,8,9]])
    end

    it 'identifies the rows with winning combinations for 4-in-a-row' do
      expect(BoardSetup.new.find_winning_rows(4,4)).to eq([[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]])
    end
  end

  describe '.find_winning_left_diagonal' do
    it 'identifies the top left diagonal winning combination for 3-in-a-row by default' do
      expect(BoardSetup.new.find_winning_left_diagonal).to eq([1,5,9])
    end

    it 'identifies the top left diagonal winning combination for 4-in-a-row' do
      expect(BoardSetup.new.find_winning_left_diagonal(4,4)).to eq([1,6,11,16])
    end
  end

  describe '.find_winning_right_diagonal' do
    it 'identifies the top right diagonal winning combination for 3-in-a-row by default' do
      expect(BoardSetup.new.find_winning_right_diagonal).to eq([3,5,7])
    end

    it 'identifies the top right diagonal winning combination for 4-in-a-row' do
      expect(BoardSetup.new.find_winning_right_diagonal(4,4)).to eq([4,7,10,13])
    end
  end
  
end
