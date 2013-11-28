require_relative 'bike_container'

class Garage

  include BikeContainer

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
  end

  def dock(bike)
    super
    fix_all
  end

  def defaults
    {capacity: 100}
  end

  def fix_all
    bikes.each { |bike| bike.fix }
  end

end
