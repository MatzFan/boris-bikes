class User

  $stations = [DockingStation.new(name: 'Bank'),
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
    @location.dock(bike)
    # @location.full? ? go_to_another_station : @location.dock(bike)
  end

  def try_to_pick_up_bike
    @bike = location.release_a_working_bike
    # @location.empty? ? @bike = location.release_a_working_bike : go_to_another_station
  end

  # def go_to_another_station
  #   @location = $stations[rand($stations.count)]
  # end

  def has_bike?
    @bike
  end

end # end of describe
