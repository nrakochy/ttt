class GetInput
  def user_input(input_stream = $stdin)
    input_stream.gets.chomp
  end
end
    
