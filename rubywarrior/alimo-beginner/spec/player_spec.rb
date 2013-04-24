require 'rspec-fakes'
require 'ostruct'
require_relative '../player.rb'

describe Player do
  context "no obstacle" do
    let(:space) { OpenStruct.new(:empty? => true) }

    it "should walk forward" do
      player = Player.new
      warrior = fake
      warrior.stub(:feel).and_return(space)
      player.play_turn(warrior)
      warrior.should have_received(:walk!)
    end
  end

  context "with obstacle" do
    let(:space) { OpenStruct.new(:empty? => false) }
    it "should attack obstacle" do
      player = Player.new
      warrior = fake
      warrior.stub(:feel).and_return(space)
      player.play_turn(warrior)
      warrior.should have_received(:attack!)
    end
  end
end
