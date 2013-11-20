class Garage

  require_relative 'bike_container'

  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def fix(bike)
    bike.fix
  end

end
