class Wagon
  include Manufacturer

  attr_reader :type, :wagons

  def initialize(_option, type)
    @type = type
    validate!
  end

  def valid?
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'passenger или cargo' if (@type != 'passenger') && (@type != 'cargo')
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
    raise 'Все места уже заняты.' if @taked_places == @places
    @free_places -= 1
    @taked_places += 1
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
    raise "Осталось #{@free_volume} ед объема." if @free_volume - volume < 0
    @free_volume -= volume
    @filled_volume += volume
  end
end
