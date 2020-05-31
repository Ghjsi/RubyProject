class Station
  attr_reader :name, :trains
  

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train_name)
    @trains << train_name
  end

  def send_train(train_name)
     @trains.delete(train_name)
  end
end