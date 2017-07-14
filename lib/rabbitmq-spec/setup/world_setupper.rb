module RabbitMQSpec::Setup::WorldSetupper
  class << self
    def call(world, _client)
      world.exchanges.each do |exchange|
        setup_exchange(exchange)
      end
    end

    def setup_exchange(exchange, client)
      client.exchange(exchange.name, exchange.options)
      exchange.queues.each do |queue|
        client.queue(queue.name, queue.options)
      end
    end
  end
end
