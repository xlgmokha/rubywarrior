class Player

  def initialize
    @behaviours = [Rest.new, Attack.new, Walk.new]
  end

  def play_turn(warrior)
    @behaviours.each do |action|
      action.play(warrior) if action.matches(warrior)
    end
  end
end

class GoodHealth
  FIFTY_PERCENT = 0.5

  def matches(warrior)
    @initial_health ||= warrior.health
    health_is_good(warrior)
  end

  private

  def health_is_good(warrior)
    threshold = FIFTY_PERCENT * @initial_health
    warrior.health > threshold
  end
end

class Attack
  def initialize(good_health = GoodHealth.new)
    @good_health = good_health
  end

  def matches(warrior)
    warrior.feel.empty? == false && @good_health.matches(warrior)
  end

  def play(warrior)
    warrior.attack!
  end
end

class Rest
  def initialize(good_health = GoodHealth.new)
    @good_health = good_health
  end

  def matches(warrior)
    !warrior.feel.empty? && !@good_health.matches(warrior)
  end

  def play(warrior)
    warrior.rest!
  end
end

class Walk
  def matches(warrior)
    warrior.feel.empty?
  end

  def play(warrior)
    warrior.walk!
  end
end
