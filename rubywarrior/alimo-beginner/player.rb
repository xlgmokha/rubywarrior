class Player
  def play_turn(warrior)
    @initial_health ||= warrior.health
    if warrior.feel.empty?
      warrior.walk!
    else
      warrior.rest! if health_is_low(warrior)
      warrior.attack!
    end
  end

  def health_is_low(warrior)
    threshold = 0.5 * @initial_health
    p "threshold is #{threshold}, initial health: #{@initial_health}, current: #{warrior.health}"
    warrior.health <= threshold
  end
end
