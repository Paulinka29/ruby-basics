# frozen_string_literal: true

class Train
  attr_reader :number, :type, :route
  attr_accessor :length, :speed, :current_station

  def initialize(number, type, length)
    @number = number
    @type = type
    @length = length
    @speed = 0
  end

  def speed_boost(boost)
    @speed = speed + boost
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @length = (length + 1) if speed.zero?
  end

  def remove_carriage
    @length = length - 1 if speed.zero?
  end

  def route=(route)
    @route = route
    @current_station = route.f_station
    current_station.trains << self
  end

  def move_forward
    station = next_station

    return 'move forward is impossible' if station.is_a?(String)

    perform_movement(station)
  end

  def move_back
    station = previos_station

    return 'move back is impossible' if station.is_a?(String)

    perform_movement(station)
  end

  def perform_movement(station)
    current_station.departed(self)
    @current_station = station

    current_station.arrived(self)
  end

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
