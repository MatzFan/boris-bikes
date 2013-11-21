class Van

  require_relative 'bike_container'

  include BikeContainer

  attr_reader :location

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def release(bike)
    if !empty?
      location.dock(bike)
      bikes.delete(bike)
    end
  end

  def release_all(bikes)
    bikes.each { |bike| release(bike) }
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.respond_to? :bike_count)
    @location = new_location
    process_bikes
  end

  private
  def process_bikes
    if location.respond_to? :fix_all
      release_all(broken_bikes)
    elsif location.is_a? DockingStation
      release_all(available_bikes)
      dock_all(location.broken_bikes)
    end
  end

end
