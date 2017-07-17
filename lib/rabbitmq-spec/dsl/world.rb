# Class to generate instances for the DSL evaluation
# @api private
# @attr exchanges [Array<RabbitMQSpec::Entity::Exchange>]
# @attr single_queues [Array<RabbitMQSpec::Entity::Queue>]

class RabbitMQSpec::DSL::World
  attr_reader :exchanges
  attr_reader :single_queues

  def initialize
    @exchanges = []
    @single_queues = []
  end

  # DSL exchange keyword
  # @attr name [String] Name of the exchange
  # @yield Block to be evaluated on RabbitMQSpec::DSL::Builder::Exchange build proccess
  def exchange(name, &block)
    new_exchange = RabbitMQSpec::DSL::Builder::Exchange.build(name: name, &block)
    @exchanges << new_exchange
  end

  # DSL queue keyword
  # @attr name [String] Name of the queue
  # @yield Block to be evaluated on RabbitMQSpec::DSL::Builder::Exchange build proccess
  def queue(name, &block)
    new_queue = RabbitMQSpec::DSL::Builder::Queue.build(name: name, &block)
    @single_queues << new_queue
  end
end
