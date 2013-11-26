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
    $docking_stations = [] # required to reset to empty for testing
    @bikes = []
    @output = output
    @garage = Garage.new(capacity: 100)
    @van = Van.new(capacity: 15)
    @van.go_to @garage
    create_docking_stations
    half_fill_stations
    @users = []
    $docking_stations.each do |station|
      10.times do
        @users << User.new
      end
    end
  end

  def step
    @bikes.each { |bike| bike.break if rand(10) == 0 }
    users.each do |user|
      user.go_to(another_station(user.location))
    end
    van_fix_bikes
    display
  end

  def van_fix_bikes
    previous_location = priority_location
    van.go_to(previous_location)
    puts "VAN IS AT #{van.location.name}"
    puts "Van has #{van.broken_bikes.count} broken and #{van.available_bikes.count} FIXED"
    van.go_to garage
    puts "VAN IS AT #{van.location}"
       puts "Van has #{van.broken_bikes.count} broken and #{van.available_bikes.count} FIXED"
    van.go_to(previous_location)
  end

  def priority_location
    $docking_stations.inject($docking_stations.first) do |memo, station|
      (station.broken_bikes.count > memo.broken_bikes.count) ? station : memo
    end
  end

  def another_station(station = nil)
    other_stations = $docking_stations.reject { |s| s == station }
    other_stations[rand(other_stations.count)]
  end

  def start(num_steps)
    users.each { |user| user.go_to(another_station) }
    num_steps.times { step }
  end

  def create_docking_stations
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

  def user_by_station
    user_count = {}
    users.each { |user| user_count[user.location] =
      (user_count[user.location] || 0) + 1 }
    user_count
  end

  def display
    user_count = user_by_station # gets number of users at each station
    format({station: "Station", capacity: "Capacity",
            available: "Available", broken: "Broken", users: "Users"})
    $docking_stations.each do |station|
      format({station: station.name,
              capacity: station.capacity,
              available: station.available_bikes.count,
              broken: station.broken_bikes.count,
              users: user_count[station]})
    end
    puts
  end

  def format(args)
    printf("%-12s %8s %10s %8s %12s\n", args[:station], args[:capacity],
                                   args[:available], args[:broken], args[:users],)
  end

end # of class

sim = Simulator.new(STDOUT)
sim.start(3)
