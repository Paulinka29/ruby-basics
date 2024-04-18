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

  def freight_train
    trains.select { |train| train.type == :freight }
  end

  def passenger_train
    trains.select { |train| train.type == :passenger }
  end

  def departed(train)
    trains.delete(train)
  end
end
