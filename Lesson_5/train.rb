# frozen_string_literal: true

class Train
  attr_reader :number, :type, :route
  attr_accessor :speed, :current_station, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def speed_boost(boost)
    @speed = speed + boost
  end

  def stop
    @speed = 0
  end

  def remove_wagon
    if speed.nonzero?
      puts 'Невозможно удалить вагон, т.к скорость != 0'
    elsif wagons.empty?
      puts 'Невозможно удалить вагон, т.к вагоны отсутствуют'
    else
      wagons.pop
      puts 'Вагон успешно отцеплен'
    end
  end

  def add_route(route)
    @route = route
    @current_station = route.first_station
    current_station.trains << self
    puts 'маршрут успешно добавлен'
  end

  def move_forward
    if current_station.name == route.last_station.name
      puts 'перемещение вперед невозможно'
    else
      perform_movement(next_station)
      puts 'поезд успешно перемещен вперед'
    end
  end

  def move_back
    if current_station.name == route.first_station.name
      puts 'перемещение назад невозможно'
    else
      perform_movement(previos_station)
      puts 'поезд успешно перемещен назад'
    end
  end

  def perform_movement(station)
    current_station.departed(self)
    @current_station = station

    current_station.arrived(self)
  end

  protected

  def previos_station
    return 'previos station does not exist' if current_station_index.zero?

    route.list[current_station_index - 1]
  end

  def next_station
    return 'next station does not exist' if current_station_index == route.list.size - 1

    route.list[current_station_index + 1]
  end

  def current_station_index
    route.list.find_index(current_station)
  end
end
