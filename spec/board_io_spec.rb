require_relative '../lib/board_io'
require_relative '../lib/fake_io'

describe BoardIO do
  let(:io) { FakeIO.new }

  it 'gets input from the user' do
    io.input << "test"
    expect(io.get_input).to eq("test")
  end

  it 'prints output to the console' do
    test = "test"
    expect(io.print_output(test)).to eq(["test"])
  end
end
