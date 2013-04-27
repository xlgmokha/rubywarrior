class Player
  def play_turn(warrior)
    if warrior.feel.empty?
      if warrior.health == 20
        warrior.walk!
      else
        warrior.rest!
      end
    else
      if warrior.health == 20
        warrior.attack!
      else
        warrior.walk!(:backward)
      end
    end
  end
end
