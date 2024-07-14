# frozen_string_literal: true
require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  class << self  
    alias_method :all, :instances
  end  

  def initialize(name, trains = [])
    @name = name
    @trains = trains
    register_instance
  end

  def arrived(train)
    trains << train
  end

  def departed(train)
    trains.delete(train)
  end
end
