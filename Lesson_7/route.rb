# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'

class Route
  include InstanceCounter
  include Validation
  attr_reader :first_station, :last_station, :way_stations

  NAME_FORMAT = /[а-я]+/i.freeze

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @way_stations = []
    validate!
    register_instance
  end

  def add_way(station)
    if list.map(&:name).include? station.name
      puts 'станция уже существует в маршруте'
    else
      way_stations << station
      puts "станция успешно добавлена в маршрут #{name}"
    end
  end

  def remove_way(station)
    if (first_station.name == station.name) || (last_station.name == station.name)
      puts 'удаление первой/последней станции невозможно'
    elsif !(way_stations.map(&:name).include? station.name)
      puts 'данной станции не существует в маршруте'
    else
      way_stations.delete(station)
      puts "станция #{station.name} успешно удалена из маршрута #{name}"
    end
  end

  def list
    ([first_station] + way_stations + [last_station])
  end

  def name
    "#{first_station.name} - #{last_station.name}"
  end

  def validate!
    raise ArgumentError, 'Название станции не может быть пустым!' if first_station.nil? || last_station.nil?

    if (first_station.name !~ NAME_FORMAT) || (last_station.name !~ NAME_FORMAT)
      raise ArgumentError,
            'Название станции должно задаваться на русском языке'
    end
  end
end
