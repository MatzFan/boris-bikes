class User

  STATIONS = [DockingStation.new(name: 'Bank'),
               DockingStation.new(name: 'Old Street'),
               DockingStation.new(name: 'Monument')]

  attr_accessor :location, :bike

  def initialize
    @bike = nil
    @location = nil
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.is_a? DockingStation)
    @location = new_location
    has_bike? ? try_to_dock_bike : try_to_pick_up_bike
  end

  def try_to_dock_bike
    @location.full? ? go_elsewhere : @location.dock(bike); bike = nil
  end

  def try_to_pick_up_bike
    @location.available_bikes.nil? ? go_elsewhere : @bike = @location.release_a_working_bike
  end

  def go_elsewhere
    go_to($docking_stations[rand($docking_stations.count)])
  end

  def has_bike?
    bike
  end

end # end of describe
