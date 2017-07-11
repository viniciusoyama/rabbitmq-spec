class RabbitMQSpec::DSL::World::Queue
  attr_reader :name, :description, :options

  def initialize(name, description, options)
    @name = name
    @description = description
    @options = options
  end
end
