# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main1
  attr_reader :routes, :trains, :stations

  def initialize
    @routes = []
    @trains = []
    @stations = []
  end

  def manage_stations
    puts "Список станций: #{stations.map(&:name).join(', ')}"
    puts 'Выберите номер действия:'
    puts '1: создать станцию'

    action = gets.chomp.to_i

    if action == 1
      create_station

    else
      puts 'Неверное действие'
    end
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp

    station_object = stations.find { |station| station.name == name }

    if station_object
      puts 'Станция с таким именем уже существует'
    else
      stations << Station.new(name)
      puts 'Станция успешно добавлена'
    end
  rescue => e
    puts e.message
    retry
  end

  def manage_routes
    puts "Список маршрутов: #{routes.map(&:name).join(', ')}"
    puts 'Выберите номер действия:'
    puts '1: создать маршрут'
    puts '2: редактировать маршрут'
    action = gets.chomp.to_i
    case action
    when 1
      create_route
    when 2
      edit_route
    else
      puts 'Неверное действие'
    end
  end

  def create_route
    puts "Список станций: #{stations.map(&:name).join(', ')}"

    puts 'Выберите первую станцию'
    first_station = gets.chomp
    first_station_object = stations.find { |station| station.name == first_station }
    raise 'Станция не существует' unless first_station_object

    puts 'Выберите последнюю станцию'
    last_station = gets.chomp
    last_station_object = stations.find { |station| station.name == last_station }
    raise 'Станция не существует' unless last_station_object

    routes << Route.new(first_station_object, last_station_object)
    puts 'Маршрут успешно добавлен'
  rescue => e
    puts e.message
    retry
  end

  def edit_route
    puts "Список маршрутов: #{routes.map(&:name).join(', ')}"
    puts 'Введите название маршрута для редактирования'

    name = gets.chomp

    route_object = routes.find { |route| route.name == name }

    puts 'Маршрут не найден' unless route_object

    puts 'Выберите действие'
    puts '1: добавить станцию'
    puts '2: удалить станцию'

    action = gets.chomp.to_i

    case action
    when 1
      add_station(route_object)
    when 2
      remove_station(route_object)
    else
      puts 'Неверное действие/Маршрут не найден'
    end
  end

  def add_station(route)
    puts "Список доступных станций: #{stations.map(&:name).join(',')}"
    puts "Список станций в маршруте: #{route.list.map(&:name).join(',')}"
    puts 'Введите название станции'
    name = gets.chomp
    station_object = stations.find { |station| station.name == name }

    if station_object
      route.add_way(station_object)
    else
      'Станция не найдена'
    end
  end

  def remove_station(route)
    puts "Список доступных станций: #{stations.map(&:name).join(',')}"
    puts "Список станций в маршруте: #{route.list.map(&:name).join(',')}"
    puts 'Введите название станции'
    name = gets.chomp
    station_object = stations.find { |station| station.name == name }

    if station_object
      route.remove_way(station_object)
    else
      'Станция не найдена'
    end
  end

  def manage_trains
    list = trains.map { |train| "#{train.number}-#{train.type}" }.join(', ')
    puts "Список поездов и типов: #{list}"

    puts 'Выберите номер действия:'
    puts '1: добавить новый поезд'
    puts '2: изменить состав поезда'
    puts '3: управление маршрутами поездов'
    action = gets.chomp.to_i
    case action
    when 1
      create_train
    when 2
      edit_train
    when 3
      manage_trains_routes
    else
      puts 'Неверное действие'
    end
  end

  def create_train
    puts 'Выберите тип поезда: 1 - грузовой, 2 - пассажирский'
    type = gets.chomp.to_i

    if [1, 2].include? type
      puts 'Введите номер поезда'
      number = gets.chomp
    else
      puts 'Такого типа не существует'
      return
    end

    train = case type
            when 1
              CargoTrain.new(number, CargoTrain::TYPE)
            when 2
              PassengerTrain.new(number, PassengerTrain::TYPE)
            end

    trains << train
    puts 'Поезд успешно добавлен'
  rescue => e
    puts e.message
    retry
  end

  def edit_train
    list = trains.map { |train| "#{train.number}-#{train.type}" }.join(', ')
    puts "Список поездов и типов: #{list}"

    puts 'Введите номер поезда, состав которого необходимо изменить'
    number = gets.chomp

    puts 'Выберите тип поезда: 1 - грузовой, 2 - пассажирский'
    type = gets.chomp

    type_class = type == '1' ? CargoTrain::TYPE : PassengerTrain::TYPE

    changed_train = trains.find { |train| train.number == number && train.type == type_class }

    unless changed_train
      puts 'Поезд не найден'
      return
    end

    puts 'Для добавления вагона выберите 1, для удаления вагона из состава выберите 2'
    action = gets.chomp.to_i
    case action
    when 1
      changed_train.add_wagon
      puts 'Вагон успешно добавлен'
    when 2
      changed_train.remove_wagon
    else
      puts 'Неверное действие'
    end
  end

  def manage_trains_routes
    list = trains.map { |train| "#{train.number}-#{train.type}" }.join(', ')
    puts "Список поездов и типов: #{list}"

    puts 'Выберите номер действия:'
    puts '1: назначить маршрут поезду'
    puts '2: переместить поезд вперед по маршруту'
    puts '3: переместить поезд назад по маршруту'

    action = gets.chomp.to_i

    puts 'Введите номер поезда'
    number = gets.chomp

    puts 'Выберите тип поезда: 1 - грузовой, 2 - пассажирский'
    type = gets.chomp

    type_class = type == 1 ? CargoTrain::TYPE : PassengerTrain::TYPE

    train  = trains.find { |t| t.number == number && t.type == type_class }

    unless train
      puts 'Поезд не найден'
      return
    end

    case action
    when 1
      puts "Список маршрутов: #{routes.map(&:name).join(', ')}"
      puts 'Введите название маршрута для добавления'

      name = gets.chomp

      route = routes.find { |r| r.name == name }

      unless route
        puts 'Маршрут не найден'
        return
      end

      train.add_route(route)
    when 2
      train.move_forward
      puts "текущая станция: #{train.current_station.name}"
    when 3
      train.move_back
      puts "текущая станция: #{train.current_station.name}"
    else
      puts 'Неверное действие'
    end
  end

  def list_stations_with_trains
    puts 'Список станций и поездов на них'

    stations.each_with_index do |station, index|
      trains = station.trains.map(&:number)
      puts "#{index + 1}. Станция #{station.name}, список поездов: #{trains}"
    end
  end

  def start_main_loop
    loop do
      puts 'Выберите номер действия:'
      puts '1: управление станциями'
      puts '2: управление маршрутами'
      puts '3: управление поездами'
      puts '4: список станций и поездов'

      action = gets.chomp.to_i
      case action
      when 1
        manage_stations
      when 2
        manage_routes
      when 3
        manage_trains
      when 4
        list_stations_with_trains
      else
        puts 'Неверное действие'
      end
    end
  end
end
Main1.new.start_main_loop
