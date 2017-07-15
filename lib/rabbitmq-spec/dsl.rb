# Namespace for all DSL logic.
# Use this module to evaluate a string in our DSL format
# and fetch a world instance containing all the entities extracted
# from the DSL specification
# @example
#    RabbitMQSpec::DSL.evaluate(%Q{
#      exchange 'name1' do
#        description %Q{ My Exchange }
#      end
#    })
module RabbitMQSpec::DSL
  autoload :World, 'rabbitmq-spec/dsl/world'
  autoload :Builder, 'rabbitmq-spec/dsl/builder'

  # @param dsl String in the DSL format to be evaluated by.
  # @return [World] Configured by the DSL definition.
  def self.evaluate(dsl)
    world = World.new
    world.instance_eval(dsl)
    world
  end
end
