require 'van'

describe Van do

let(:station) { DockingStation.new(capacity: 12) }
let(:van) { Van.new(capacity: 15) }
let(:garage) { Garage.new }
let(:bike) { Bike.new }

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(15)
  end

  it "should be able to go to a docking station" do
    van.go_to(station)
    expect(van.location).to be(station)
  end

  it "should be able to go to a garage" do
    van.go_to(garage)
    expect(van.location).to be(garage)
  end

  it "should not be able to go to somewhere that doesn't handle bikes" do
    expect(lambda { van.go_to("Moon") }).to raise_error(RuntimeError)
  end

  it "should be able to release a bike at a location and that bike then be at the location" do
    van.dock(bike)
    van.go_to(station)
    expect(van.bike_count).to eq(1)
    expect(station.bike_count).to eq(0)
    van.release(bike)
    expect(van.bike_count).to eq(0)
    expect(station.bike_count).to eq(1)
  end

  it "should pick up all broken bikes at a docking station" do
    working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
    broken_bike1.break; broken_bike2.break
    station.dock_all([working_bike, broken_bike1, broken_bike2])
    expect(station.broken_bikes).to eq([broken_bike1, broken_bike2])
    expect(station.bike_count).to eq(3)
    van.go_to(station)
    expect(van.location.is_a? DockingStation).to be_true
    expect(van.bike_count).to eq(2)
  end

  it "should release all it's broken bikes at a place that fixes them" do
    working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
    broken_bike1.break; broken_bike2.break
    van.dock_all([working_bike, broken_bike1, broken_bike2])
    expect(van.bike_count).to eq(3)
    van.go_to(garage)
    expect(van.bike_count).to eq(1)
  end

end # of describe
