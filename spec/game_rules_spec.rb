require_relative '../lib/game_rules'

describe GameRules do 
  
  let(:winning_3board_combos) { [[0,1,2],[3,4,5],[6,7,8],[0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]] }
  let(:winning_4board_combos) { [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15],[0,5,10,15], [3,6,9,12]] }
  let(:board_size3) { 3 }
  let(:board_size4) { 4 }

  describe '#winner?' do
    context 'default 3x3 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [0,1,2]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [3,1,2]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [0,3,1,2]
        expect(GameRules.new.winner?(player_moves, winning_3board_combos)).to eq(true)
      end

      it 'returns false if player moves does not include winning combo among other moves' do 
        player_moves = [0,2,6,8]
        expect(GameRules.new.winner?(player_moves,winning_3board_combos)).to eq(false)
      end
    end

    context '4x4 board' do
      it 'returns true if player moves has a winning combination' do 
        player_moves = [0,1,2,3]
        expect(GameRules.new.winner?(player_moves, winning_4board_combos, board_size4)).to eq(true)
      end

      it 'returns false if player moves does not have a winning combination' do 
        player_moves = [4,2,3,9]
        expect(GameRules.new.winner?(player_moves, winning_4board_combos, board_size4)).to eq(false)
      end

      it 'returns true if player moves includes winning combo among other moves' do 
        player_moves = [0,1,2,4,9,3]
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
      expect(GameRules.new.find_winning_columns).to eq([[0,3,6], [1,4,7], [2,5,8]])
    end

    it 'identifies the columns with winning combinations for 4-in-a-row' do
      expect(GameRules.new.find_winning_columns(4,4)).to eq([[0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15]])
    end
  end

  describe '.find_winning_rows' do
    it 'identifies the rows with winning combinations for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_rows).to eq([[0,1,2],[3,4,5],[6,7,8]])
    end

    it 'identifies the rows with winning combinations for 4-in-a-row' do
      expect(GameRules.new.find_winning_rows(4,4)).to eq([[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15]])
    end
  end

  describe '.find_winning_left_diagonal' do
    it 'identifies the top left diagonal winning combination for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_left_diagonal).to eq([0,4,8])
    end

    it 'identifies the top left diagonal winning combination for 4-in-a-row' do
      expect(GameRules.new.find_winning_left_diagonal(4,4)).to eq([0,5,10,15])
    end
  end

  describe '.find_winning_right_diagonal' do
    it 'identifies the top right diagonal winning combination for 3-in-a-row by default' do
      expect(GameRules.new.find_winning_right_diagonal).to eq([2,4,6])
    end

    it 'identifies the top right diagonal winning combination for 4-in-a-row' do
      expect(GameRules.new.find_winning_right_diagonal(4,4)).to eq([3,6,9,12])
    end
  end
  
end
