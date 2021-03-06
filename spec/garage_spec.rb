require 'garage'
require './lib/bike'

describe Garage do

  let(:garage) { Garage.new }
  let(:bike) { Bike.new }

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(100)
  end

  it "should fix broken bikes" do
    bike.break
    garage.dock(bike)
    expect(bike).not_to be_broken
  end

end # of describe
