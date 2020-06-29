require_relative 'counter'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :trains
  attr_accessor_with_history :name

  validate :name, :presence

  # rubocop:disable Style/ClassVars
  @@all_stations = []
  # rubocop:enable Style/ClassVars

  def self.all
    @@all_stations
  end

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@all_stations << self
    validate!
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def take_train(train_name)
    @trains << train_name
  end

  def send_train(train_name)
    @trains.delete(train_name)
  end

  def get_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end
end
