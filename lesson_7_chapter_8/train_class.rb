require_relative 'counter'

class Train

  include Manufacturer 
  include InstanceCounter  

  NUM_FORMAT = /[[:alnum:]]{3}-?[a-z]{2}|\d{2}/i

  attr_reader :speed, :route, :current_station, :composition
  attr_accessor :num

  
  @@trains = []
 
  def self.find(num) 
    @@trains.find { |object| object.num == num }
  end

  def initialize(num)
    register_instance
    @num = num
    @speed = 0
    @route = nil
    @current_station = nil
    @@trains << self
    @composition = []
    validate!  
  end
  
  def every_wagon (&block)
    @composition.each { |wagon| yield(wagon) }
  end


  def accelerate(speed)
    raise if (@speed -= speed) < 0
    @speed += speed 
  end

  def brake
    @speed = 0
  end

  def route= (route)   
    @route = route
    @current_station = @route.stations_in_route[0]
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
    @composition << wagon if self.type == wagon.type
  end
  
  def detach_wagon(wagon = nil)
    if wagon.nil?
      @composition.pop
    else
      @composition.delete(wagon)
    end
  end

  def valid?
    true
  rescue 
    false
  end
  
 protected 

  def validate! 
    raise 'Некорректный формат номера поезда.' if num !~ NUM_FORMAT
    raise 'Скорость не может быть отрицательной' if @speed < 0
  end

  def next_station
    return if @route.nil? 
    index_next_station = @route.stations_in_route.index(@current_station) + 1 
    return if index_next_station > @route.stations_in_route.size - 1
    @route.stations_in_route[index_next_station]
  end 

  def prev_station
    return if @route.nil?
    index_prev_station = @route.stations_in_route.index(@current_station) - 1 
    return if index_prev_station < 0
    @route.stations_in_route[index_prev_station]
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
    super
  end
end

class CargoTrain < Train
  attr_reader :type

  private

  def initialize(num)
    @type = 'cargo'
    super
  end
end