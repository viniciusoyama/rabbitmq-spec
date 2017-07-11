module RabbitMQSpec::DSL
  autoload :World,   'rabbitmq-spec/dsl/world'

  def self.evaluate(&block)
    world = World.new
    world.instance_eval(&block)
    world
  end
end
