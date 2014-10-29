require_relative '../lib/board_io'
require 'stringio'

describe BoardIO do
  it 'gets input from the user' do
    test = StringIO.new("test")
    expect(BoardIO.new.get_input(test)).to eq("test")
  end

  it 'prints output to the console' do
    fake = StringIO.new
    expect(BoardIO.new.print_output("test", fake)).to eq("test")
  end
end
