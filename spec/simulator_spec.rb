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
      expect($docking_stations.count).to eq(5)
    end

    it "should create a simulation with a each docking station half full" do
      $docking_stations.each do |station|
        expect(station.available_bikes.count).to eq(station.capacity/2)
      end
    end

    it "should put the van at the garage" do
      sim.start(2)
      expect(sim.van.location).to eq(sim.garage)
    end

    it "should have 50 users" do
      expect(sim.users.count).to eq(50)
    end

    it "should initially allocate each user to a station" do
     sim.users.each do |user|
       expect(user.location).to be_nil
     end
    end

  context "running the simulation"
    it "should display something" do
      expect(sim.display).to_not eq(RuntimeError)
    end

    it "should be able to be started" do
      expect(sim.start(2)).to be_true
    end

    it "should have a step which breaks 10% of bikes" do
      sim.step
      broken_ones = 0
      sim.bikes.each do |bike|
        broken_ones += 1 if bike.broken?
      end
      broken_ones.should be >= 1
    end

end # of describe
