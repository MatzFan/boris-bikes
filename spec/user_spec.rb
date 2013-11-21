require 'user'

describe User do

  let(:station) { DockingStation.new(capacity: 20) }
  let(:user) { User.new }
  let(:bike) { Bike.new }
  let(:user_with_bike) { station.dock(bike); user.go_to(station); user }

  it "should not be able to go somewhere that isn't a docking station" do
    expect(lambda { user.go_to("Moon")}).to raise_error(RuntimeError)
  end

  it "should be able to take a bike, if a station has one" do
    station.dock(bike)
    expect(station.bike_count).to eq(1)
    expect(station.available_bikes).to eq([bike])
    expect(user.bike).to be_nil
    expect(station.available_bikes.count).to eq(1)
    user.go_to(station)
    expect(user.bike).to eq(bike)
    expect(station.bike_count).to eq(0)
  end

  it "should not be able to take a bike, if a station has none" do
    bike.break
    station.dock(bike)
    expect(station.bike_count).to eq(1)
    user.go_to(station)
    expect(station.bike_count).to eq(1)
  end

  it "should be able to return a working bike to a docking station" do
    station.dock(bike)
    user.go_to(station)
    expect(user.bike).to eq(bike)
    expect(station.bike_count).to eq(0)
    user.go_to(station)
    expect(station.bike_count).to eq(1)
  end

end # of describe
