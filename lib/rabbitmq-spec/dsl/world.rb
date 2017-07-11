class RabbitMQSpec::DSL::World
  attr_reader :exchanges

  def initialize
    @exchanges = []
  end

  def exchange(name, &block)
    new_exchange = RabbitMQSpec::DSL::Builder::Exchange.build(name: name, &block)
    new_exchange.instance_eval(&block) if block_given?
    @exchanges << new_exchange
  end
end
