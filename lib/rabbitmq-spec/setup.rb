require 'bunny'

# Does the AMPQ Broker setup by reading all mqspecs files
# evaluating them and connecting to the borker using the provided url
# in order to create all exchanges, queues and bindings
# @example
#   RabbitMQSpec::Setup.run(['/my/path/folde1', 'my/direct_mqspec/file.rb'], 'amqp://guest:guest@localhost:5672')
class RabbitMQSpec::Setup
  autoload :Runner, 'rabbitmq-spec/setup/runner'
  autoload :WorldSetupper, 'rabbitmq-spec/setup/world_setupper'
  autoload :WorldFetcher, 'rabbitmq-spec/setup/world_fetcher'

  class << self
    def run(files_paths:, url:)
      with_client(url) do |client|
        RabbitMQSpec::Setup::Runner.new(files_paths, client).run
      end
    end

    # @private
    def with_client(ampq_broker_url)
      client = Bunny.new(ampq_broker_url, automatically_recover: false)
      channel = nil
      begin
        client.start
        channel = client.create_channel
        yield(channel)
      rescue Exception => ex
        raise ex
      ensure
        channel and channel.close
        client and client.close
      end
    end
  end
end
