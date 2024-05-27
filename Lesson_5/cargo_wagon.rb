# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  TYPE = :cargo

  def initialize
    @type = TYPE
  end
end
