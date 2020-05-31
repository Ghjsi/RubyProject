class Train
  attr_reader :speed, :num, :route 
  
  def initialize(num)
    @num = num
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

  def hitch_wagon(wagon)
    @train_composition << wagon if self.type == wagon.type
  end
  
  def detach_wagon(wagon = nil)
    if wagon.nil?
      @train_composition.pop
    else
      @train_composition.delete(wagon)
    end
  end
  
 protected 
  
  def next_station # все три метода не требуются к выводу пользователю, но нужны субклассам для выполнения метода движения
    return if @route.nil? 
    index_next_station = @route.stations.index(@current_station) + 1 
    return if index_next_station > @route.stations.size - 1
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

class PassengerTrain < Train
  attr_reader :type

  private
  
  def initialize(num)
    @type = 'passenger'
    @train_composition = []
    super
  end
end

class CargoTrain < Train
  attr_reader :type

  private

  def initialize(num)
    @type = 'cargo'
    @train_composition = []
    super
  end
end

class Wagon
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

class PassengerWagon < Wagon
  def initialize(type = 'passenger')
    super
  end
end

class CargoWagon < Wagon 
  def initialize(type = 'cargo') 
    super
  end
end
