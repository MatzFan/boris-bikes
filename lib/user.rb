class User

  attr_reader :location

  def go_to(new_location)
    raise "Can't go to #{new_location}" if !(new_location.is_a? DockingStation)
    @location = new_location
  end

end
