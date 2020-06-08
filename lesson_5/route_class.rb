require_relative 'counter'

class Route
  attr_reader :stations_in_route, :name 
  
  include InstanceCounter
  
  def initialize(first_station, last_station, name)
    register_instance
    @stations_in_route = [first_station, last_station]
    @name = name
  end   

  def add_middle_station(station)
    @stations_in_route.insert(-2, station)
  end

  def delete_middle_station(station)
    @stations_in_route.delete(station)
  end

  def display_stations
    print 'Маршрут следования:'
    @stations_in_route.each do |station|
      print station.name 
      print ' -> ' if station != @stations_in_route.last
    end
  end
end