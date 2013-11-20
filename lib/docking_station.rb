class DockingStation

  require_relative 'bike_container'

  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
  end

  def empty?
    bike_count == 0
  end

end # of class
