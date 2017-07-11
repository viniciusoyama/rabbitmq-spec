# frozen_string_literal: true

class RabbitMQSpec::Entity::Exchange
  attr_accessor :name
  attr_accessor :description
  attr_accessor :queues
  attr_accessor :options
end
