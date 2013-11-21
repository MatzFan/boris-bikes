class User

  attr_accessor :location, :bike

  def initialize
    @bike = nil
    @location = nil
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.is_a? DockingStation)
    @location = new_location
    if has_bike?
      @location.dock(bike)
    else
      @bike = location.release_a_working_bike
    end
  end

  def has_bike?
    @bike
  end

end # end of describe
