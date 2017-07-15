# Represents an exchange in the AMPQ broker 
class RabbitMQSpec::Entity::Exchange
  attr_accessor :name
  attr_accessor :description
  attr_accessor :queues
  attr_accessor :options

  def initialize
    @queues = []
    @options = {}
  end
end
