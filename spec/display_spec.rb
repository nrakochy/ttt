require_relative '../lib/display'

describe Display do

  it 'creates a board for 3-in-a-row' do 
    expect(Display.new.new_board).to eq([1,2,3,4,5,6,7,8,9])
  end
  
  it 'creates a board for 4-in-a-row' do 
    expect(Display.new.new_board(4)).to eq([1,2,3,4,5,6,7,8,9, 10, 11, 12, 13, 14, 15, 16])
  end



end
