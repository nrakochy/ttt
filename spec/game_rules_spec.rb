require_relative '../lib/game_rules'

describe GameRules do 
  
  let(:winning_3board_combos) { [[1,2,3],[4,5,6],[7,8,9],[1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]] }
  let(:winning_4board_combos) { [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16], [1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16],[1,6,11,16], [4,7,10,13]] }
  let(:board_size3) { 3 }
  let(:board_size4) { 4 }

  describe '#winner?' do
    context 'default 3x3 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [1,2,3]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [4,2,3]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [1,4,2,3]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(true)
      end

      it 'returns false if player moves does not include winning combo among other moves' do 
        player_moves = [1,3,7,9]
        expect(GameRules.new.winner?(player_moves,winning_3board_combos)).to eq(false)
      end
    end

    context '4x4 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [1,2,3,4]
        expect(GameRules.new.winner?(player_moves, winning_4board_combos, board_size4)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [4,2,3,9]
        expect(GameRules.new.winner?(player_moves, winning_4board_combos, board_size4)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [1,2,3,8,10,4]
        expect(GameRules.new.winner?(player_moves,winning_4board_combos, board_size4)).to eq(true)
      end
      
      it 'returns false if player moves does not include winning combo among other moves' do 
        player_moves = [1,8,9,13,16]
        expect(GameRules.new.winner?(player_moves, winning_4board_combos, board_size4)).to eq(false)
      end
    end
  end

  describe '.find_winning_columns' do
    it 'identifies the columns with winning combinations for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_columns).to eq([[1,4,7], [2,5,8], [3,6,9]])
    end

    it 'identifies the columns with winning combinations for 4-in-a-row' do
      expect(GameRules.new.find_winning_columns(4,4)).to eq([[1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16]])
    end
  end

  describe '.find_winning_rows' do
    it 'identifies the rows with winning combinations for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_rows).to eq([[1,2,3], [4,5,6], [7,8,9]])
    end

    it 'identifies the rows with winning combinations for 4-in-a-row' do
      expect(GameRules.new.find_winning_rows(4,4)).to eq([[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]])
    end
  end

  describe '.find_winning_left_diagonal' do
    it 'identifies the top left diagonal winning combination for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_left_diagonal).to eq([1,5,9])
    end

    it 'identifies the top left diagonal winning combination for 4-in-a-row' do
      expect(GameRules.new.find_winning_left_diagonal(4,4)).to eq([1,6,11,16])
    end
  end

  describe '.find_winning_right_diagonal' do
    it 'identifies the top right diagonal winning combination for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_right_diagonal).to eq([3,5,7])
    end

    it 'identifies the top right diagonal winning combination for 4-in-a-row' do
      expect(GameRules.new.find_winning_right_diagonal(4,4)).to eq([4,7,10,13])
    end
  end
  
end
