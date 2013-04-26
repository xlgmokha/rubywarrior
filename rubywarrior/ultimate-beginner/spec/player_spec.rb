require 'rspec'
require 'rspec-fakes'
require_relative '../player'

describe Player do
  let(:sut) { Player.new }
  let(:warrior) { fake }


  context "when there is no obstacle" do
    let(:feeling) { fake }

    before :each do
      warrior.stub(:feel).and_return(feeling)
      feeling.stub(:empty?).and_return(true)
    end

    before { sut.play_turn(warrior) }

    it "should walk" do
      warrior.should have_received(:walk!)
    end
  end

  context "when there is sludge in front of you" do
    let(:feeling) { fake }

    before :each do
      warrior.stub(:feel).and_return(feeling)
      feeling.stub(:empty?).and_return(false)
    end

    before { sut.play_turn(warrior) }

    it "should attack the sludge" do
      warrior.should have_received(:attack!)
    end
  end
end
