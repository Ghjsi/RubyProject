require_relative 'counter'

class Station
  attr_reader :name, :trains
  
  include InstanceCounter
  
  def self.all 
    puts "Список станций:"
    @@all_stations.each do |station|
      puts "#{station.name}"
    end  
  end
  
  @@all_stations = []
  
  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@all_stations << self 
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
end