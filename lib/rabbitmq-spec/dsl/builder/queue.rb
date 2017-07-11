class RabbitMQSpec::DSL::Builder::Queue < RabbitMQSpec::DSL::Builder::Base
  define_entity_class RabbitMQSpec::Entity::Queue

  define_dsl_attribute :name
  define_dsl_attribute :description
  define_dsl_attribute :routing_key
  define_dsl_attribute :options
end
