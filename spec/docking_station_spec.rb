require 'docking_station'

describe DockingStation do

let(:station) { DockingStation.new(capacity: 12) }

  it "should allow setting default capacity on initialising" do
    expect(station.capacity).to eq(12)
  end

  it "should know when it's empty" do
    expect(DockingStation.new).to be_empty
  end

end # of describe
