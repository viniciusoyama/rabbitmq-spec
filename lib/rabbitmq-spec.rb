require 'rabbitmq-spec/version'

# Global RabbitMQ namespace
module RabbitMQSpec
  autoload :DSL, 'rabbitmq-spec/dsl'
  autoload :Entity, 'rabbitmq-spec/entity'
  autoload :Setup, 'rabbitmq-spec/setup'
end
