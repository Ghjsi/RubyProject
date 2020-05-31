class Route
  attr_reader :stations 
  
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end
   

  def add_middle_station(station)
    @stations.insert(1, station)
  end

  def delete_middle_station(station)
    @stations.delete(station)
  end
end