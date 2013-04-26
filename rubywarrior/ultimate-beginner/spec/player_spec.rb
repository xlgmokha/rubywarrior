require 'rspec'
require 'rspec-fakes'
require_relative '../player'

describe Player do
  let(:sut) { Player.new }

  context "when resting" do
    let(:warrior) { fake }

    before :each do
      sut.play_turn(warrior)
    end

    it "should walk forward" do
      warrior.should have_received(:walk!)
    end
  end
end
