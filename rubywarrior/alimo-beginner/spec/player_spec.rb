require 'rspec-fakes'
require 'ostruct'
require_relative '../player.rb'

describe Player do
  let(:player) { Player.new }
  let(:warrior) { fake }

  context "when there is no obstacle in the way" do
    let(:space) { OpenStruct.new(:empty? => true) }

    it "should walk forward" do
      warrior.stub(:feel).and_return(space)
      player.play_turn(warrior)
      warrior.should have_received(:walk!)
    end
  end

  context "when there is an obstacle in the way" do
    let(:space) { OpenStruct.new(:empty? => false) }

    before :each do
      warrior.stub(:feel).and_return(space)
    end

    context "when the player has more than 50% of it's original health" do
      let(:starting_health) { 20 }

      before :each do
        warrior.stub(:health).and_return(starting_health)
        player.play_turn(warrior)
      end

      it "should attack obstacle" do
        warrior.should have_received(:attack!)
      end

      it "should not rest" do
        warrior.should_not have_received(:rest!)
      end
    end

    context "when our health reaches 50%" do
      let(:starting_health) { 20 }

      before :each do
        warrior.stub(:health).and_return(starting_health)
        player.play_turn(warrior)
      end

      it "should step back and rest" do
        new_warrior = fake
        new_warrior.stub(:health).and_return(starting_health * 0.5)
        new_warrior.stub(:feel).and_return(space)
        player.play_turn(new_warrior)
        new_warrior.should have_received(:rest!)
      end
    end
  end
end
