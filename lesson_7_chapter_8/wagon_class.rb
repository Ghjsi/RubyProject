class Wagon

  include Manufacturer
  
  attr_reader :type, :wagons

  #@@wagons = []

  def initialize(option, type)
    @type = type
    validate!
   # @@wagons << self
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

  attr_reader :places, :taked_places, :free_places

  def initialize(places, type = 'passenger')
    super
    @places = places
    @free_places = places
    @taked_places = 0
  end

  def take_place
    if @taked_places == @places
      raise 'Все места уже заняты.'
    else
    @free_places -= 1
    @taked_places += 1
    end
  end
end

class CargoWagon < Wagon 
  attr_reader :volume, :free_volume, :filled_volume

  def initialize(volume, type = 'cargo') 
    super
    @volume = volume
    @free_volume = volume
    @filled_volume = 0
  end

  def fill(volume)
    if @free_volume - volume < 0
      raise "Цистерна переполнится. Осталось #{@free_volume} единиц свободного объема."
    else
      @free_volume -= volume
      @filled_volume += volume
    end
  end

end