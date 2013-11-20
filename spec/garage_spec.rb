require 'garage'

describe Garage do

  let(:garage) { Garage.new(capacity: 123) }
  let(:bike) { Bike.new }

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(123)
  end

  it "given a broken bike it should return a fixed bike" do
    bike.break
    garage.dock(bike)
    garage.fix(bike)
    expect(bike).not_to be_broken
  end

end # of describe
