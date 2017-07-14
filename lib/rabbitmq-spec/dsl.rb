module RabbitMQSpec::DSL
  autoload :World, 'rabbitmq-spec/dsl/world'
  autoload :Builder, 'rabbitmq-spec/dsl/builder'

  def self.evaluate(dsl)
    world = World.new
    world.instance_eval(dsl)
    world
  end
end
