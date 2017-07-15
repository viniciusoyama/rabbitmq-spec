# Represents an exchange in the AMPQ broker
# @attr name [String]
# @attr description [String]
# @attr queues [Array<RabbitMQSpec::Entity::Queue>]
# @attr options [Hash] Configuration options

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
