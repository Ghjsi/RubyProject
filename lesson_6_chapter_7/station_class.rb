require_relative 'counter'

class Station
  
  include InstanceCounter

  attr_reader :name, :trains
  
  def self.all 
    @@all_stations
  end
  
  @@all_stations = []
  
  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@all_stations << self 
    validate!
  end

  def take_train(train_name)
    @trains << train_name
  end

  def send_train(train_name)
     @trains.delete(train_name)
  end

  def get_trains_by_type(type)
    @trains.select { |train| train.type == type}
  end

  def valid?
    true
  rescue 
    false
  end

  private

  def validate!
    raise 'Укажите название станции.' if name.length == 0
  end
end