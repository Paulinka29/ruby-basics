# frozen_string_literal: true

class Route
  attr_reader :first_station, :last_station, :way_stations

  def initialize(first_station, last_station, way_stations)
    @first_station = first_station
    @last_station = last_station
    @way_stations = way_stations
  end

  def add_way(station)
    way_stations << station
  end

  def remove_way(station)
    way_stations.delete(station)
  end

  def list
    [first_station] + way_stations + [last_station]
  end
end
