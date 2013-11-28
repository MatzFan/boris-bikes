require_relative 'bike_container'

class Van

  include BikeContainer

  attr_reader :location

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
    @garage = args[:garage]
  end

  def defaults
    {capacity: 20}
    {garage: nil}
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.respond_to? :bike_count)
    @location = new_location
    process_bikes_at_garage if at_a_garage?
    process_bikes_at_docking_station if at_a_docking_station?
  end

  def priority_location
    Stations.all.inject(Stations.all.first) do |memo, station|
      (station.broken_bikes.count > memo.broken_bikes.count) ? station : memo
    end
  end

  private
  def process_bikes_at_garage
    location.dock_all(release_broken_bikes(location.bike_spaces))
    dock_all(location.release_working_bikes(bike_spaces))
  end

  def process_bikes_at_docking_station
    location.dock_all(release_working_bikes(location.bike_spaces))
    dock_all(location.release_broken_bikes(bike_spaces))
  end

  def at_a_garage?
    location.respond_to? :fix_all
  end

  def at_a_docking_station?
    location.is_a? DockingStation
  end

end
