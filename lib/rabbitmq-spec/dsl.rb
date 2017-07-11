# frozen_string_literal: true

module RabbitMQSpec::DSL
  autoload :World, 'rabbitmq-spec/dsl/world'
  autoload :Builder, 'rabbitmq-spec/dsl/builder'

  def self.evaluate(&block)
    world = World.new
    world.instance_eval(&block)
    world
  end
end
