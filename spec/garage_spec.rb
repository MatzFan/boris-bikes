require 'garage'

describe Garage do

  let(:garage) { Garage.new(capacity: 123) }

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(123)
  end

end # of describe
