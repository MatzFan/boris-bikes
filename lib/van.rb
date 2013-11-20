class Van

  require_relative 'bike_container'

  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def go_to(location)
    raise "Can't go to #{location}" if !location.respond_to? :bike_count
    @location = location
  end

end
