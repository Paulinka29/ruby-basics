# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name, trains = [])
    @name = name
    @trains = trains
  end

  def arrived(train)
    trains << train
  end

  def departed(train)
    trains.delete(train)
  end
end
