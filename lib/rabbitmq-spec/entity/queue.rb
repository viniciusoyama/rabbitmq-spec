class RabbitMQSpec::Entity::Queue
  attr_accessor :name
  attr_accessor :description
  attr_accessor :routing_key
  attr_accessor :options

  def initialize
    @options = {}
  end
end
