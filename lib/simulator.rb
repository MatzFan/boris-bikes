class Simulator

  attr_reader :garage, :van, :docking_stations, :users

  def initialize
    @garage = Garage.new(capacity: 100)
    @van = Van.new(capacity: 15)
    @docking_stations = [DockingStation.new(name: 'Bank', capacity: 20),
                         DockingStation.new(name: 'Old Street', capacity: 12),
                         DockingStation.new(name: 'Monument', capacity: 10),
                         DockingStation.new(name: 'Waterloo', capacity: 16),
                         DockingStation.new(name: 'Shoreditch', capacity: 10)]
    half_fill_stations
    @users = users = []; 50.times { users << User.new}
  end

  def half_fill_stations
    docking_stations.each do |station|
      (station.capacity/2).times { station.dock(Bike.new) }
    end
  end


end # of class
