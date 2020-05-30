#list_of_trains = []

class Station
  attr_reader :name, :trains
  

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train_name)
    @trains << train_name
  end
  
  def types_of_trains_on_station(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train_name)
     @trains.delete(train_name)
  end
end

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

class Train
  attr_reader :speed, :num_wagons, :type, :num, :route 
  
  def initialize(num, type, num_wagons) # type is 'cargo' or 'passenger'
    @num = num
    @type = type
    @num_wagons = num_wagons
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def accelerate(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def hitch_wagon(wagons)
    @num_wagons += wagons 
  end

  def route= (route)   
    @route = route
    @current_station = @route.stations[0]
    @current_station.take_train(self)
  end

    def move_to_next_station   
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.take_train(self)
  end

  def move_to_prev_station
    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.take_train(self)
  end
  

  def next_station
    return if @route.nil? #прервать метод,если маршрут не содержит станций
    index_next_station = @route.stations.index(@current_station) + 1 #определяем индекс следующей станции
    return if index_next_station > @route.stations.size - 1 # прервать метод, если индекс следующей станции превышает индекс последнего элемента в маршруте
    @route.stations[index_next_station]
  end 

  def prev_station
    return if @route.nil?
    index_prev_station = @route.stations.index(@current_station) - 1 
    return if index_prev_station < 0
    @route.stations[index_prev_station]
  end

  def neighbour_station
    return if @route.nil?
    [prev_station, @current_station, next_station]
  end
end