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

    context "when your health is full" do
      before { warrior.stub(:health).and_return(20) }

      before { sut.play_turn(warrior) }

      it "should walk" do
        warrior.should have_received(:walk!)
      end
    end

    context "when your health is low" do
      before { warrior.stub(:health).and_return(19) }

      before { sut.play_turn(warrior) }

      it "should rest" do
        warrior.should have_received(:rest!)
      end
    end
  end

  context "when there is sludge in front of you" do
    let(:feeling) { fake }

    before :each do
      warrior.stub(:feel).and_return(feeling)
      feeling.stub(:empty?).and_return(false)
    end

    context "when your health is full" do
      before :each do
        warrior.stub(:health).and_return(20)
      end

      before { sut.play_turn(warrior) }

      it "should attack the sludge" do
        warrior.should have_received(:attack!)
      end
    end

    context "when your health is low" do
      before :each do
        warrior.stub(:health).and_return(19)
      end
      it "should walk backwards then rest" do
        sut.play_turn(warrior)
        warrior.should have_received(:walk!, :backward)
      end
    end
  end
end
