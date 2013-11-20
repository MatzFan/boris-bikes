require 'van'

describe Van do

let(:station) { DockingStation.new(capacity: 12) }
let(:van) { Van.new(capacity: 15) }

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(15)
  end

end # of describe
