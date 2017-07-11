class RabbitMQSpec::DSL::Builder::Exchange < RabbitMQSpec::DSL::Builder::Base
  define_entity_class RabbitMQSpec::Entity::Exchange

  define_dsl_attribute :name
  define_dsl_attribute :description
  define_dsl_attribute :options

  def queue(name, &block)
    @builded_attributes[:queues] ||= []
    @builded_attributes[:queues] << RabbitMQSpec::DSL::Builder::Queue.build(name: name, &block)
  end
end
