require 'van'
require 'bike'
require 'docking_station'
require 'garage'


describe Van do

let(:station) { DockingStation.new(capacity: 20) }
let(:van) { Van.new(capacity: 15) }
let(:garage) { Garage.new }
let(:bike) { Bike.new }

  def twenty_available_bikes
    20.times.inject([]) { |bikes, n| bikes << Bike.new }
  end

  def twenty_broken_bikes
    twenty_available_bikes.each { |bike| bike.break }
  end


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

  it "should pick up all broken bikes at a docking station" do
    working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
    broken_bike1.break; broken_bike2.break
    station.dock_all([working_bike, broken_bike1, broken_bike2])
    expect(station.broken_bikes).to eq([broken_bike1, broken_bike2])
    expect(station.bike_count).to eq(3)
    van.go_to(station)
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

  it "should fill a docking station with fixed bikes" do
    working_bike1, working_bike2, broken_bike = Bike.new, Bike.new, Bike.new
    broken_bike.break
    van.dock_all([working_bike1, working_bike2, broken_bike])
    expect(van.available_bikes).to eq([working_bike1, working_bike2])
    expect(station.bike_count).to eq(0)
    expect(van.bike_count).to eq(3)
    van.go_to(station)
    expect(van.location).to eq(station)
    expect(van.bike_count).to eq(1)
    expect(station.bike_count).to eq(2)
  end





  it "should be full after visiting a docking station with lots of broken bikes" do
    station.dock_all(twenty_broken_bikes)
    expect(station.broken_bikes.count).to eq(20)
    van.go_to(station)
    expect(van.capacity).to eq(15)
    expect(van.bike_count).to eq(15)
  end

end # of describe
