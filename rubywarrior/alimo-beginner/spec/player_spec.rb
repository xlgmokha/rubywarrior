require 'rspec-fakes'
require_relative '../player.rb'

describe Player do
  context "when playing" do
    it "should walk forward" do
      player = Player.new
      warrior = fake
      player.play_turn(warrior)
      warrior.should have_received(:walk!)
    end
  end
end
