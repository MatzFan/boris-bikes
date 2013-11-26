class User

  attr_accessor :location, :bike

  def initialize
    @bike = nil
    @location = nil
  end

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.is_a? DockingStation)
    @location = new_location
    has_bike? ? try_to_dock_bike : try_to_pick_up_bike
  end

  def try_to_dock_bike
    unless @location.full?
      @location.dock(bike)
      bike = nil
    end
  end

  def try_to_pick_up_bike
    @bike = @location.release_a_working_bike unless @location.available_bikes.nil?
  end

  def has_bike?
    bike
  end

end # end of describe
