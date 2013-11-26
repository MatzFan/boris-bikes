Station::NAMES

module Station

  NAMES = ['Bank', 'Old Street', 'Monument', 'Waterloo', 'Shoreditch']
  CAPACITIES = 20, 12, 10, 16, 10
  ATTRIBUTES = Hash[STATION_NAMES.zip(STATION_CAPACITIES)]

  def self.all
    @docking_stations || create_docking_stations
  end

  private
  def self.create_docking_stations
    STATION_ATTRIBUTES.each_pair do |name, capacity|
      @docking_stations << DockingStation.new(name: name, capacity: capacity)
    end
    @docking_stations
  end

end
