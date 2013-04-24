
class Greeting
  def self.say(message)
    message
  end

end
describe "hello" do
  it "should say hi" do
    Greeting.say("hi").should == "hi"
  end
end
