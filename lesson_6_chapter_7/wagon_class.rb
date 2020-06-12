class Wagon

  include Manufacturer
  
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    true
  rescue 
    false
  end

  protected

  def validate!
    raise 'Тип вагона должен быть passenger или cargo.' if (@type != 'passenger') && (@type != 'cargo')
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