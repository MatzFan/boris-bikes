class DockingStation

  DEFAULT_NAME = 'Unknown'

  # require_relative 'bike_container'

  attr_accessor :name

  include BikeContainer

  def initialize(args = {})
    args = defaults.merge(args)
    @capacity = args[:capacity]
    @name = args[:name]
  end

  def defaults
    {name: 'Unknown', capacity: 10}
  end

end # of class
