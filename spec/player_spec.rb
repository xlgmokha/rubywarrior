require 'spec_helper'

describe Player do
  context "when playing" do
    it "should walk forward" do
      player = Player.new
      warrior = fake
      player.play(warrior)
      warrior.should have_received(:walk!)
    end
  end
end
