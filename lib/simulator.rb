#!/usr/bin/env ruby

require_relative 'garage'
require_relative 'van'
require_relative 'docking_station'
require_relative 'user'
require_relative 'bike'


class Simulator

  NAMES = ['Bank', 'Old Street', 'Monument', 'Waterloo', 'Shoreditch']
  CAPACITIES = 20, 12, 10, 16, 10
  ATTRIBUTES = Hash[NAMES.zip(CAPACITIES)]

  attr_reader :garage, :van, :users, :bikes, :docking_stations

  def initialize(output)
    @docking_stations = []
    create_docking_stations
    @bikes = []
    @output = output
    @garage = Garage.new(capacity: 100)
    @van = Van.new(capacity: 15, garage: @garage)
    @van.go_to @garage
    half_fill_stations
    @users = []
    docking_stations.each { 10.times { @users << User.new } }
  end

  def create_docking_stations
    ATTRIBUTES.each_pair do |name, capacity|
      @docking_stations << DockingStation.new(name: name, capacity: capacity)
    end
    @docking_stations
  end

  def step
    loop do
      puts "Another step?"
      break if gets.chomp != 'y'
      @bikes.each { |bike| bike.break if rand(10) == 0 }
      users.each do |user|
        user.go_to(another_station(user.location))
      end
      display
      van_fix_bikes
    end
  end

  def van_fix_bikes
    previous_location = priority_location
    van.go_to(previous_location)
    van.go_to garage
    van.go_to(previous_location)
  end

  def priority_location
    docking_stations.inject(docking_stations.first) do |memo, station|
      (station.broken_bikes.count > memo.broken_bikes.count) ? station : memo
    end
  end

  def another_station(station = nil)
    other_stations = docking_stations.reject { |s| s == station }
    other_stations[rand(other_stations.count)]
  end

  def start(num_steps)
    users.each { |user| user.go_to(another_station) }
    step
    # num_steps.times { step }
  end

  def half_fill_stations
    puts "CALLED"
    @docking_stations.each do |station|
      (station.capacity/2).times do
        bikes << Bike.new
        station.dock(bikes.last)
      end
      puts "#{station.name} has #{station.bike_count} bikes"
    end
  end

  def user_by_station
    user_count = {}
    users.each { |user| user_count[user.location] =
      (user_count[user.location] || 0) + 1 }
    user_count
  end

  def available_bike_total
    count = 0
    bikes.each { |bike| count += 1 if !bike.broken?}
    count
  end

  def broken_bike_total
    count = 0
    bikes.each { |bike| count += 1 if bike.broken?}
    count
  end

  def display
    user_count = user_by_station # gets number of users at each station
    display_titles
    docking_stations.each do |station|
      format({station: station.name,
              capacity: station.capacity,
              available: station.available_bikes.count,
              broken: station.broken_bikes.count,
              users: user_count[station]})
    end
    puts
    puts "Total working bikes = #{available_bike_total}"
    puts "Total broken bikes = #{broken_bike_total}"
  end

  def display_titles
    format({station: "Station", capacity: "Capacity",
            available: "Available", broken: "Broken", users: "Users"})
  end

  def format(args)
    printf("%-12s %8s %10s %8s %12s\n", args[:station], args[:capacity],
                                   args[:available], args[:broken], args[:users],)
  end

end # of class

sim = Simulator.new(STDOUT)
sim.start(10)
