class Van

  require_relative 'bike_container'

  include BikeContainer

  attr_reader :location

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
    # self.capacity = options.fetch(:capacity, capacity)
  end

  def defaults
    {capacity: 20}
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.respond_to? :bike_count)
    @location = new_location
    process_bikes_at_garage if at_a_garage?
    process_bikes_at_docking_station if at_a_docking_station?
  end

  private
  def process_bikes_at_garage
    location.dock_all(release_all_broken_bikes)
    dock_all(location.release_all_working_bikes)
  end

  def process_bikes_at_docking_station
    location.dock_all(release_all_working_bikes)
    dock_all(location.release_all_broken_bikes)
  end

  def at_a_garage?
    location.respond_to? :fix_all
  end

  def at_a_docking_station?
    location.is_a? DockingStation
  end

end
