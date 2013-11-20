class Van

  require_relative 'bike_container'

  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def release(bike)
    @location.dock(bike)
    bikes.delete(bike)
  end

  def go_to(location)
    raise "Can't go to #{location}" if !location.respond_to? :bike_count
    @location = location
    if !location.respond_to? :fix
      location.dock(broken_bikes)
    end
    location # return location value to indicate failure/success
  end

end
