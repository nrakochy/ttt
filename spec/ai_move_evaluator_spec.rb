require_relative '../lib/ai_move_evaluator'

describe AIMoveEvaluator do
  context '3x3 board' do
    let(:move_evaluator){ AIMoveEvaluator.new([[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]) }

    it '#check_for_win returns true if player1_moves + possible move includes winning combo' do
    end
  end
end
