require 'simulator'

describe Simulator do

  let(:simulation) {Simulator.new}

  it "should create a simulation with a garage" do
    expect(simulation.garage.is_a? Garage).to be_true
  end

  it "should create a simulation with a van" do
    expect(simulation.van.is_a? Van).to be_true
  end

  it "should create a simulation with a 5 docking stations" do
    expect(simulation.docking_stations.count).to eq(5)
  end

  it "should create a simulation with a each docking station half full" do
    simulation.docking_stations.each do |station|
      expect(station.available_bikes.count).to eq(station.capacity/2)
    end
  end

  it "should create 50 users" do
    expect(simulation.users.count).to eq(50)
  end

end # of describe
