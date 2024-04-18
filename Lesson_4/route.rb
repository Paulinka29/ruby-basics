# frozen_string_literal: true

class Route
  attr_reader :f_station, :l_station, :w_stations

  def initialize(f_station, l_station, w_stations)
    @f_station = f_station
    @l_station = l_station
    @w_stations = w_stations
  end

  def add_way(station)
    w_stations << station
  end

  def remove_way(station)
    w_stations.delete(station)
  end

  def list
    [f_station] + w_stations + [l_station]
  end
end
