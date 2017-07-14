module RabbitMQSpec::Setup::WorldSetupper
  class << self
    def call(world, client)
      world.exchanges.each do |exchange|
        setup_exchange(exchange, client)
      end
    end

    def setup_exchange(exchange, client)
      client.exchange(exchange.name, exchange.options)
      exchange.queues.each do |queue|
        client.queue(queue.name, queue.options)
        if queue.routing_key.nil?
          queue.bind(exchange.name)
        else
          queue.bind(exchange.name, routing_key: queue.routing_key)
        end
      end
    end
  end
end
