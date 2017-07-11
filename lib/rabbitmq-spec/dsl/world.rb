class RabbitMQSpec::DSL::World
  autoload :Queue,   'rabbitmq-spec/dsl/world/queue'
  autoload :Exchange,   'rabbitmq-spec/dsl/world/exchange'

  attr_reader :exchanges

  def initialize
    @exchanges = []
  end

  def exchange(name, description, options, &block)
    new_exchange = RabbitMQSpec::DSL::World::Exchange.new(name, description, options)
    new_exchange.instance_eval(&block) if block_given?
    @exchanges << new_exchange
  end
end
