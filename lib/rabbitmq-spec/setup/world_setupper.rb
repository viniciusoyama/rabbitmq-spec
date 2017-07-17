# @api private
# It uses the client to configure the RabbitMQ
# according with the world object
# @example
#   RabbitMQSpec::Setup::WorldSetupper.(world, client)
module RabbitMQSpec::Setup::WorldSetupper
  class << self
    def call(world, client)
      world.exchanges.each do |exchange|
        setup_exchange(exchange, client)
      end
      world.single_queues.each do |queue|
        setup_queue(queue, client)
      end
    end

    def setup_exchange(exchange, client)
      client.exchange(exchange.name, exchange.options)
      exchange.queues.each do |queue|
        client_queue = client.queue(queue.name, queue.options)
        if queue.routing_key.nil?
          client_queue.bind(exchange.name)
        else
          client_queue.bind(exchange.name, routing_key: queue.routing_key)
        end
      end
    end

    def setup_queue(queue, client)
      client.queue(queue.name, queue.options)
    end
  end
end
