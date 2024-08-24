# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  NAME_FORMAT = /[а-я]+/i.freeze

  class << self
    alias all instances
  end

  def initialize(name, trains = [])
    @name = name
    @trains = trains
    validate!
    register_instance
  end

  def arrived(train)
    trains << train
  end

  def departed(train)
    trains.delete(train)
  end

  def validate!
    raise ArgumentError, 'Название станции не может быть пустым!' if name.nil?
    raise ArgumentError, 'Название станции должно задаваться на русском языке!' if name !~ NAME_FORMAT
  end
end
