# @api private
# Namespace for all DSL builders.
# Each builder is a class that implements the DSL methods that are called when evaluating the DSL
class RabbitMQSpec::DSL::Builder
  autoload :Base, 'rabbitmq-spec/dsl/builder/base'
  autoload :Queue, 'rabbitmq-spec/dsl/builder/queue'
  autoload :Exchange, 'rabbitmq-spec/dsl/builder/exchange'
end
