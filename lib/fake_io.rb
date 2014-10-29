class FakeIO

  def gets(input_stream = $stdin)
    input_stream.chomp
  end

  def print(input_stream = $stdout)
    input_stream.chomp
  end

  def set_next_get
  end

  def set_last_print
  end

end
