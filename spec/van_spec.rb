require 'van'

describe Van do

let(:station) { DockingStation.new(capacity: 12) }
let(:van) { Van.new(capacity: 15) }
let(:garage) { Garage.new }

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

end # of describe
