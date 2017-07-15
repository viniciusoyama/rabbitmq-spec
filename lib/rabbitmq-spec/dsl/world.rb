# Class to generate instances for the DSL evaluation
# @api private
# @attr exchanges [Array<RabbitMQSpec::Entity::Exchange>]

class RabbitMQSpec::DSL::World
  attr_reader :exchanges

  def initialize
    @exchanges = []
  end

  # DSL exchange keyword
  # @attr name [String] Name of the exchange
  # @yield Block to be evaluated on RabbitMQSpec::DSL::Builder::Exchange build proccess
  def exchange(name, &block)
    new_exchange = RabbitMQSpec::DSL::Builder::Exchange.build(name: name, &block)
    @exchanges << new_exchange
  end
end
