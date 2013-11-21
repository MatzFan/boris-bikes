class Garage

  require_relative 'bike_container'

  include BikeContainer

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
  end

  def defaults
    {capacity: 100}
  end

  def fix_all(bikes)
    bikes.each { |bike| bike.fix }
  end

end
