require_relative 'manufacturer'
require_relative 'validate'

class Wagon
  include Manufacturer
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type 
    validate!
  end

  def validate! 
    raise ArgumentError, "Неверный тип вагона!" if type !~ /(cargo|passenger)/i
  end 
end 
