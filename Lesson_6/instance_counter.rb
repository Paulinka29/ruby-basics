module InstanceCounter 
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def instances
      @instances ||= []
    end
  end

  private

  def register_instance
    self.class.instances << self
  end
end
