class Player
  FIFTY_PERCENT = 0.5

  def play_turn(warrior)
    @initial_health ||= warrior.health
    if warrior.feel.empty?
      warrior.walk!
    else
      if health_is_low(warrior)
        warrior.rest!
      else
        warrior.attack!
      end
    end
  end

  def health_is_low(warrior)
    threshold = FIFTY_PERCENT * @initial_health
    warrior.health <= threshold
  end
end
