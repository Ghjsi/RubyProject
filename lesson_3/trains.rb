#list_of_trains = []

class Station
  attr_reader :station_name
  

  def initialize(station_name)
    @station_name = station_name
    @trains_on_station_list = []
  end
  
  def trains_on_station
    puts @trains_on_station_list
  end

  def take_train(train_name)
    @trains_on_station_list << train_name
  end
  
  def types_of_trains_on_station(type)
    @trains_on_station_list.select { |train| train.type == type }
  end

  def sending_train(train_name)
     @trains_on_station_list.delete(train_name)
  end
end

class Route
  attr_reader :route 
  
  def initialize(first_station, last_station)
    @route = []
    @route[0] = first_station
    @route[1] = last_station
  end
   

  def add_middle_station(station)
    @route.insert(1, station)
  end

  def delete_middle_station(station)
    @route.delete(station)
  end

  def display_route
    puts 'В маршрут входят следующие станции: '
    @route.each { |station| puts station.station_name }
  end
end

class Train
  attr_reader :speed, :num_wagons, :type, :num, :route #, :current_station, :prev_station, :next_station
  
  def initialize(num, type, num_wagons) # type is 'cargo' or 'passenger'
    @num = num
    @type = type
    @num_wagons = num_wagons
    @speed = 0
    @route = nil
    @current_station = nil
    @index = 0 
  end

  def accelerate(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def hitch_wagon(num_wagons)
    if @speed == 0 && num_wagons > 0
      num_wagons.times { @num_wagons += 1 }
    elsif @speed == 0 && num_wagons < 0
      num_wagons.abs.times { @num_wagons -= 1 }
    else
      puts 'Ошибка. Поезд не совершил остановку для выполнения данной операции.'
    end
  end

  def route= (route)   
    @route = route
    @current_station = @route.route[0]
    @current_station.take_train(self)
  end

  def move_to_next_station # поезд не может развернуться на полпути                 
    @prev_station = @current_station
      case
      when @index + 1 < @route.route.size
        @current_station.sending_train(self)
        @current_station = @route.route[@index + 1]
        @current_station.take_train(self)
        @index += 1
        @next_station = @route.route[@index + 1]
      when @index + 1 == @route.route.size
        @next_station = @route.route[@index - 1]
        return 'Поезд находится на конечной станции. Возможно движение только в обратную сторону.'
      end
  end

  def move_to_prev_station # поезд не может развернуться на полпути
    @prev_station = @current_station
 
      case
      when @index - 1 > 0 
        @current_station.sending_train(self)
        @current_station = @route.route[@index - 1]
        @current_station.take_train(self)
        @index -= 1
        @next_station = @route.route[@index - 1]
      when @index - 1 == 0
        @current_station.sending_train(self)
        @current_station = @route.route[@index - 1]
        @current_station.take_train(self)
        @index -= 1
        @next_station = @route.route[@index + 1]
      when @index - 1 < 0
        return 'Поезд находится на конечной станции. Возможно движение только в обратную сторону.'
      end
  end
  
  def prev_station
    if @current_station == @route.route.last
      @prev_station = @route.route[@index - 1]
    elsif @current_station == @route.route.first
      @prev_station = @route.route[@index + 1]
    else
    end
    puts @prev_station.station_name
  end
  
  def next_station
    i = @route.route.index(@current_station)
    if @current_station == @route.route.first
      @next_station = @route.route[i + 1]
    elsif @current_station == @route.route.last
      @next_station = @route.route[i - 1]
    end
    puts @next_station.station_name
  end
  
  def current_station
    puts @current_station.station_name
  end
end