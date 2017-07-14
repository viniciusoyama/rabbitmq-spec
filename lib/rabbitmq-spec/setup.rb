require 'bunny'

class RabbitMQSpec::Setup
  autoload :Runner, 'rabbitmq-spec/setup/runner'
  autoload :WorldSetupper, 'rabbitmq-spec/setup/world_setupper'
  autoload :WorldFetcher, 'rabbitmq-spec/setup/world_fetcher'

  class << self
    def run(files_paths: files_paths, url: url)
      with_client(url) do |client|
        RabbitMQSpec::Setup::Runner.new(files_paths, client).run
      end
    end

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
        channel&.close
        client&.close
      end
    end
  end
end
