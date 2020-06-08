class Wagon
  attr_reader :type
  
  include Manufacturer

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