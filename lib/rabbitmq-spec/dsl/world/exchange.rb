class RabbitMQSpec::DSL::World::Exchange
  attr_reader :queues

  def initialize(name, description, options)
    @name = name
    @description = description
    @options = options
    @queues = []
  end

  def queue(name, description, options)
    new_queue = RabbitMQSpec::DSL::World::Queue.new(name, description, options)
    @queues << new_queue
  end
end
