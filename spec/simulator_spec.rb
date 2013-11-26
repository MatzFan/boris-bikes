require 'simulator'

describe Simulator do

    let(:output) { double('output') }
    let(:sim) { Simulator.new(output) }

  def all_broken_bikes
    sim.bikes.select { |bike| bike.broken? }
  end

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
      expect(sim.start(1)).to be_true
    end

    it "should have a step which breaks some of bikes" do
      sim.step
      all_broken_bikes.count.should be >= 1
    end

    it "should have a step which sends users to random docking stations" do
      sim.start(1)
      old_user_locations = sim.users.map { |user| user.location.name }
      sim.step
      sim.step
      new_user_locations = sim.users.map { |user| user.location.name }
      expect(old_user_locations).to_not eq(new_user_locations)
    end

    it "should have a step which fixes some broken bikes" do
      sim.step
      sim.step
      old_broken_ones = all_broken_bikes
      sim.step
      sim.step
      now_fixed = old_broken_ones.select { |bike| !bike.broken? }
      expect(now_fixed).to_not be_empty
    end

end # of describe
