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
    expect(van.go_to(station)).not_to be(nil)
  end

  it "should be able to go to a garage" do
    expect(van.go_to(garage)).not_to be(nil)
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

end # of describe
