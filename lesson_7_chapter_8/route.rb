require_relative 'counter'

class Route
  include InstanceCounter

  attr_reader :stations_in_route, :name

  def initialize(first_station, last_station, name)
    register_instance
    @stations_in_route = [first_station, last_station]
    @name = name
    validate!
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

  def valid?
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Укажите название маршрута.' if name.length.zero?
    raise 'Должно быть минимум 2 станции' if @stations_in_route.size < 2
    raise 'станции не существует' unless @stations_in_route.each do |station|
      Station.all.include?(station)
    end
  end
end
