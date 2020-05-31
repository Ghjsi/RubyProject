require_relative 'train_class'
require_relative 'station_class'
require_relative 'route_class'


# создавать станции
solncevo = Station.new('solncevo')
kashirskaya = Station.new('kashirskaya')
perovo = Station.new('perovo')
zvonovo = Station.new('zvonovo')
konevo = Station.new('konevo')

#создавать поезда
train111 = PassengerTrain.new(111)
train222 = CargoTrain.new(222)

#создавать маршруты и управлять станциями в нем(добавлять.удалять)
route_one = Route.new(solncevo, perovo)
route_two = Route.new(solncevo, zvonovo)
route_one.add_middle_station(kashirskaya)
route_two.add_middle_station(kashirskaya)
route_two.add_middle_station(konevo)
route_two.delete_middle_station(konevo)

# назначать маршрут поезду
train111.route= route_one
train222.route= route_two

# добавлять вагоны к поезду
wp1 = PassengerWagon.new
wp2 = PassengerWagon.new
wc1 = CargoWagon.new
wc2 = CargoWagon.new
train111.hitch_wagon(wp1)
train111.hitch_wagon(wp2)
train222.hitch_wagon(wc1)
train222.hitch_wagon(wc2)

# отцеплять вагоны от поезда
train111.detach_wagon(wp2)
train222.detach_wagon

#перемещать поезд по маршруту вперед и назад
train111.move_to_next_station
train111.move_to_next_station
train111.move_to_prev_station

# просматривать список станций и список поездов на станции
route_one.stations
route_two.stations
solncevo.trains
kashirskaya.trains
perovo.trains
zvonovo.trains