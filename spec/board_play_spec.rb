require_relative '../lib/board_play'

describe BoardPlay do

    let(:winning_3board_combos) { [[1,2,3],[4,5,6],[7,8,9],[1,5,9], [3,5,7], [1,4,7], [2,5,8], [3,6,9]] }
    let(:winning_4board_combos) { [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16], [1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16],[1,6,11,16], [4,7,10,13]] }
    let(:board_size3) { 3 }
    let(:board_size4) { 4 }
 

end
