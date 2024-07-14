# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  TYPE = :cargo

  def add_wagon
    @wagons << CargoWagon.new
  end
end
