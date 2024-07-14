# frozen_string_literal: true

require_relative 'wagon'
class PassengerWagon < Wagon
  TYPE = :passenger

  def initialize
    @type = TYPE
  end
end
