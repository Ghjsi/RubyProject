require_relative 'manufacturer' ##
require_relative 'train_class'
require_relative 'station_class'
require_relative 'route_class'
require_relative 'wagon_class'


class Manager
  attr_reader :trains, :routes, :stations

  def initialize 
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    
    loop do
      menu
      choice = gets.chomp
      case choice
      when '1'
        create_station 
      when '2'         
        create_train   
      when '3'         
        create_route   
      when '4'         
        assign_route   
      when '5'         
        hitch_wagon    
      when '6'         
        detach_wagon   
      when '7'         
        move           
      when '8'          
        display_trains_on_station 
      when '9'         
        seed           
      end
      break if choice == 'quit'
    end
  end  

  private

  def seed
    @stations = []
    @trains = []
    @routes = []
   
    @stations << Station.new('Арбатская')
    @stations << Station.new('Киевская')
    @stations << Station.new('Багратионовская')
    @stations << Station.new('Покровская')
   
    @trains << PassengerTrain.new('pass-train-1')
    @trains << CargoTrain.new('cargo-train-1')
  
    @routes << Route.new(@stations[0], @stations[3], 'арбат-покров')
    @routes[0].add_middle_station(@stations[1])
    @routes[0].add_middle_station(@stations[2])

    @routes << Route.new(@stations[1], @stations[3], 'киев-покров')
    @routes[0].add_middle_station(@stations[2])
   
    @trains[0].route=(@routes[0])
    @trains[1].route=(@routes[1])

    @trains[0].hitch_wagon(PassengerWagon.new)
    @trains[0].hitch_wagon(PassengerWagon.new)
    @trains[1].hitch_wagon(CargoWagon.new)
    @trains[1].hitch_wagon(CargoWagon.new)
  end

  def menu
    puts '1 - создать новую станцию'
    puts '2 - создать новый поезд'
    puts '3 - создание или изменение маршрута'
    puts '4 - назначить маршрут поезду'
    puts '5 - прицепить вагон к поезду'
    puts '6 - отцепить вагон от поезда'
    puts '7 - переместить поезд на следующую/предыдущую станцию'
    puts '8 - просмотреть список станций и поездов на них(по типам)'
    puts '9 - удалить созданные объектовы, заменив их тестовыми'
    puts 'quit - выход'
    puts 'Введите номер нужной операции: '
  end

  def create_station
    puts 'Введите название станции:'
    name = gets.chomp
    station = Station.new(name)
    @stations.push(station)

    puts "Станция #{name} создана."
  end

  def create_train
    puts 'Укажите тип поезда.Если грузовой - введите 1, если пассажирский - введите 2.Чтобы вернуться введите - 3.'
    type = gets.chomp

    case type
    when '1'
      puts 'Введите номер поезда:'
      num = gets.chomp

      train = CargoTrain.new(num)
      puts "Грузовой поезд под номером #{num} создан."
    when '2'
      puts 'Введите номер поезда:'
      num = gets.chomp

      train = PassengerTrain.new(num)
      puts "Пассажирский поезд под номером #{num} создан."
    when '3'
      start
    else
     raise
    end
    
    @trains << train

    rescue RuntimeError
      puts 'Некорректный ввод.'
      create_train
  end

  def create_route
    puts 'Введите 1 - чтобы создать новый маршрут, 2 - чтобы изменить существующий'
    choice = gets.chomp

    case choice
    when '1'
      puts 'Список существующих станций:'
      @stations.each_with_index { |station, index| puts "#{index} - #{station.name}"}
      puts 'Введите номер первой станции маршрута:'
      first_station_index = gets.chomp.to_i
      first_station = @stations[first_station_index]
      
      puts 'Введите номер конечной станции маршрута:'
      last_station_index = gets.chomp.to_i
      last_station = @stations[last_station_index]

      puts 'Введите название для маршрута:'
      name = gets.chomp

      route = Route.new(first_station, last_station, name)
      @routes << route

      puts "Маршрут #{route.name} создан."
    when '2' 
      route_manage
    end
  end

  def route_manage
    station = nil
    station_index = nil
    route = interactive_select_route

    puts 'Введите 1, чтобы добавить станцию в маршрут, 2 - чтобы удалить станцию.'
    choice = gets.chomp

    case choice
    when '1' 
      
      @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
      
      puts 'Введите номер станции, которую нужно добавить в маршрут:'
      station_index = gets.chomp.to_i
      route.add_middle_station(@stations[station_index])
      puts "Маршрут #{route.name} изменен: станция #{@stations[station_index].name} добавлена."

    when '2' 

      loop do
        puts 'Все станции маршрута:'
        route.stations_in_route.each_with_index { |station, index| puts "#{index} - #{station.name}" }
        
        puts 'Введите номер станции, которую нужно удалить из маршрута(Нельзя удалить начальную или конечную станцию):'
        
        station_index = gets.chomp.to_i

        if station_index == 0 || route.stations_in_route[station_index] == route.stations_in_route.last # индекс станции в маршруте
          puts 'Нельзя удалить начальную или конечную станцию.'
        else 
          route.delete_middle_station(route.stations_in_route[station_index])
          puts "Маршрут #{route.name} изменен: станция удалена."
        end  
      break 
      end
    end
  end

  def assign_route 
    puts 'Список созданных поездов:'
    @trains.each_with_index { |train, index| puts "#{index} - #{train.num}" }

    puts 'Введите номер поезда, которому нужно назначить маршрут:'
    index_of_train = gets.chomp.to_i
    train = @trains[index_of_train]

    puts 'Список созданных маршрутов:'
    @routes.each_with_index  { |route, index| puts "#{index} - #{route.name}" }
    

    puts "Введит номер маршрута, который будет назначен поезду #{train.num}."
    route_index = gets.chomp.to_i
    route = @routes[route_index]
    train.route= (route)

    puts "Поезду номер #{train.num} назначен маршрут #{route.name}."
  end

  def hitch_wagon
    puts 'Список созданных поездов'
    @trains.each_with_index { |train, index| puts "#{index} - #{train.num}" }
    
    puts 'Введите номер поезда, к которому будет прицеплен вагон:'
    train_index = gets.chomp.to_i
    train = @trains[train_index]

    type = train.type
    wagon = Wagon.new(type)

    train.hitch_wagon(wagon)

    puts "К поезду #{train.num} прицеплен 1 вагон."
  end

  def detach_wagon
    puts 'Список созданных поездов'
    @trains.each_with_index { |train, index| puts "#{index} - #{train.num}" }
    
    puts 'Введите номер поезда, от которого нужно отцепить вагон:'
    train_index = gets.chomp.to_i
    train = @trains[train_index]

    if train.composition.empty?
      puts 'Ошибка.К поезду еще не прицеплено ни одного вагона.'
    else
     train.detach_wagon
    end

    puts "От поезда  #{train.num} отцеплен вагон. "
  end

  def move
    puts 'Список созданных поездов'
    @trains.each_with_index { |train, index| puts "#{index} - #{train.num}" }
    
    puts 'Введите номер поезда для отправления:'
    train_index = gets.chomp.to_i
    train = @trains[train_index]

    if train.route.nil?
      puts 'Для поезда не задан маршрут.'
      return
    else 
    end
      
    puts 'Если поезду нужно переместиться на следующую санцию, введите - 1, если на предыдущую - 2.'
    
    choice = gets.chomp
    case choice
    when '1'
      train.move_to_next_station
    when '2'
      train.move_to_prev_station
    end
    puts "Поезд #{train.num} прибыл на станцию #{train.current_station.name}"
  end



  def display_trains_on_station
     puts 'Список станций и поездов на них'
     @stations.each do |station|
       puts "Станция | #{station.name}"
       puts "\tПассажирские поезда:"
       station.get_trains_by_type('passenger').each { |train| puts "\t\t Поезд | #{train.num}" }

       puts "\tГрузовые поезда:"
       station.get_trains_by_type('cargo').each { |train| puts "\t\t Поезд | #{train.num}" }
     end
  end

  def interactive_select_route
    route = nil

    puts 'Какой маршрут нужно изменить?'
    @routes.each_with_index do |route, index|
      print "#{index} - #{route.name}" 
      route.display_stations 
    end
    print ': '
    route_index = gets.chomp.to_i
    route = @routes[route_index]
  end
end

