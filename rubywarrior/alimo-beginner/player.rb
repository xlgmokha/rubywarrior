class Player

  def initialize
    @actions = [Rest.new, Attack.new, Walk.new]
  end

  def play_turn(warrior)
    @initial_health ||= warrior.health
    @actions.each do |action|
      action.play(warrior) if action.can(warrior)
    end
  end
end

class Attack
  FIFTY_PERCENT = 0.5

  def can(warrior)
    @initial_health ||= warrior.health
    warrior.feel.empty? == false && health_is_good(warrior)
  end

  def play(warrior)
    warrior.attack!
  end

  private

  def health_is_good(warrior)
    threshold = FIFTY_PERCENT * @initial_health
    warrior.health > threshold
  end
end

class Rest
  FIFTY_PERCENT = 0.5

  def can(warrior)
    @initial_health ||= warrior.health
    warrior.feel.empty? == false && health_is_low(warrior)
  end

  def play(warrior)
    warrior.rest!
  end

  private

  def health_is_low(warrior)
    threshold = FIFTY_PERCENT * @initial_health
    warrior.health <= threshold
  end
end

class Walk
  def can(warrior)
    warrior.feel.empty?
  end

  def play(warrior)
    warrior.walk!
  end
end
