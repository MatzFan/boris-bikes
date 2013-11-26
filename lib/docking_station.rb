require_relative 'bike_container'

class DockingStation

  include BikeContainer

  DEFAULT_NAME = 'Unknown'

  attr_accessor :name

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
    @name = args[:name]
  end

  def defaults
    {name: 'Unknown', capacity: 10}
  end

end # of class
