#!/usr/bin/env ruby

require_relative 'garage'
require_relative 'van'
require_relative 'docking_station'
require_relative 'user'
require_relative 'bike'

class Simulator

  STATION_NAMES = ['Bank', 'Old Street', 'Monument', 'Waterloo', 'Shoreditch']
  STATION_CAPACITIES = 20, 12, 10, 16, 10
  STATION_ATTRIBUTES = Hash[STATION_NAMES.zip(STATION_CAPACITIES)]

  attr_reader :garage, :van, :users, :bikes

  def initialize(output)
    @bikes = []
    @output = output
    @garage = Garage.new(capacity: 100)
    @van = Van.new(capacity: 15)
    @van.go_to @garage
    create_docking_stations
    half_fill_stations
    @users = []
    $docking_stations.count.times do |station|
      10.times do
        @users << User.new
        # @Users.last.go_to(station)
      end
    end
  end

  def step
    @bikes.each { |bike| bike.break if rand(10) == 0 }
    display
  end

  def start(number_of_steps)
    number_of_steps.times do
      step
    end
  end

  def create_docking_stations
    $docking_stations = []
    STATION_ATTRIBUTES.each_pair do |name, capacity|
      $docking_stations << DockingStation.new(name: name, capacity: capacity)
    end
  end

  def half_fill_stations
    $docking_stations.each do |station|
      (station.capacity/2).times do
        bikes << Bike.new
        station.dock(bikes.last)
      end
    end
  end

  def display
    format({station: "Station", capacity: "Capacity",
            available: "Available", broken: "Broken"})
    $docking_stations.each do |station|
      format({station: station.name,
              capacity: station.capacity,
              available: station.available_bikes.count,
              broken: station.broken_bikes.count})
    end
    puts
  end

  def format(args)
    printf("%-12s %8s %10s %8s\n", args[:station], args[:capacity],
                                   args[:available], args[:broken],)
  end

end # of class

# sim = Simulator.new(STDOUT)
# sim.display
