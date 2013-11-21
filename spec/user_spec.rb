require 'user'

describe User do

  let(:station) { DockingStation.new(capacity: 20) }
  let(:user) { User.new }

  it "should be able to go to a docking station" do
    user.go_to(station)
    expect(user.location).to eq(station)

  end

  it "should not be able to go somewhere that isn't a docking station" do
    expect(lambda { user.go_to("Moon")}).to raise_error(RuntimeError)

  end

end # of describe
