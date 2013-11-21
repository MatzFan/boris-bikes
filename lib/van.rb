class Van

  require_relative 'bike_container'

  include BikeContainer

  attr_reader :location

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def release(bike)
    location.dock(bike)
    bikes.delete(bike)
  end

  def release_all(bikes)
    bikes.each { |bike| release(bike) }
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.respond_to? :bike_count)
    @location = new_location
    if location.respond_to? :fix_all
      release_all(self.broken_bikes)
    elsif location.is_a? DockingStation
      broken_ones = location.broken_bikes
      self.dock_all(broken_ones)
    end
  end

end
