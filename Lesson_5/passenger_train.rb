# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  TYPE = :passenger

  def add_wagon
    @wagons << PassengerWagon.new
  end
end
