require 'simulator'

describe Simulator do

  let(:output) {double('output') }
  let(:sim) {Simulator.new(output)}

  context "sets up a simulation"
    it "should create a simulation with a garage" do
      expect(sim.garage.is_a? Garage).to be_true
    end

    it "should create a simulation with a van" do
      expect(sim.van.is_a? Van).to be_true
    end

    it "should create a simulation with a 5 docking stations" do
      expect(sim.docking_stations.count).to eq(5)
    end

    it "should create a simulation with a each docking station half full" do
      sim.docking_stations.each do |station|
        expect(station.available_bikes.count).to eq(station.capacity/2)
      end
    end

    it "should create 50 users" do
      expect(sim.users.count).to eq(50)
    end

  context "running the simulation"
    it "should display something" do
      expect(sim.display).to_not eq(RuntimeError)
    end

    it "should be able to be started" do
      expect(sim.start).to be_true
    end

end # of describe
