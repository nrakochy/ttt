class BoardIO

  def get_input(input_stream = $stdin)
    input_stream.gets
  end

  def print_output(output, output_stream = $stdout)
    output_stream.print(output)
  end

end
