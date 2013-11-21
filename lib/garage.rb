class Garage

  require_relative 'bike_container'

  DEFAULT_CAPACITY = 100

  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def fix_all(bikes)
    bikes.each { |bike| bike.fix }
  end

end
