require_relative 'game'

class Main

 def play_ttt
   Game.new.setup_and_play_ttt
 end

end

Main.new.play_ttt
