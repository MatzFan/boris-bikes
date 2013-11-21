require 'user'

describe User do

  let(:station) { DockingStation.new(capacity: 20) }
  let(:all_stations) { [DockingStation.new(name: 'Bank'),
                        DockingStation.new(name: 'Old Street'),
                        DockingStation.new(name: 'Monument')] }
  let(:user) { User.new }
  let(:bike) { Bike.new }
  let(:user_with_bike) { station.dock(bike); user.go_to(station); user }

  def fill(station)
    station.capacity.times { station.dock(Bike.new) }
  end

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

  it "should be able to return a broken bike to a docking station" do
    station.dock(bike)
    user.go_to(station)
    expect(user.bike).to eq(bike)
    bike.break
    expect(station.bike_count).to eq(0)
    user.go_to(station)
    expect(station.bike_count).to eq(1)
  end

  it "should not be able to return a bike if a docking station is full" do
    station.dock(bike)
    user.go_to(station)
    fill(station)
    expect(station).to be_full
    user.go_to(station)
    expect(user.bike).to eq (bike)
  end

  xit "with a bike should go to another station if a station is full" do
    station.dock(bike)
    user.go_to(station)
    fill(station)
    user.go_to(station)
    expect(user.location).not_to eq (station)
  end

  xit "without a bike should go to another station if a station is empty" do
    station.dock(bike)
    user.go_to(station)
    fill(station)
    user.go_to(station)
    expect(user.location).not_to eq (station)
  end

end # of describe
