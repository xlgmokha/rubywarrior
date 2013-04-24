require 'rspec-fakes'
require 'ostruct'
require_relative '../player.rb'

describe Player do
  let(:player) { Player.new }
  let(:warrior) { fake }

  context "no obstacle" do
    let(:space) { OpenStruct.new(:empty? => true) }

    it "should walk forward" do
      warrior.stub(:feel).and_return(space)
      player.play_turn(warrior)
      warrior.should have_received(:walk!)
    end
  end

  context "with obstacle" do
    let(:space) { OpenStruct.new(:empty? => false) }
    let(:starting_health) { 20 }
    
    before :each do
      warrior.stub(:feel).and_return(space)
      warrior.stub(:health).and_return(starting_health)
    end
    it "should attack obstacle" do
      player.play_turn(warrior)
      warrior.should have_received(:attack!)
    end
    context "when our health reaches 50%" do
      it "should step back and rest" do
        player.play_turn(warrior)
        warrior.should_not have_received(:rest!)

        new_warrior = fake
        new_warrior.stub(:health).and_return(starting_health * 0.5)
        new_warrior.stub(:feel).and_return(space)
        player.play_turn(new_warrior)
        new_warrior.should have_received(:rest!)
      end
    end
  end
end
