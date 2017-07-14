class RabbitMQSpec::Setup::Runner
  def initialize(paths_to_read, client)
    @paths_to_read = paths_to_read
    @client = client
  end

  def run
    worlds.each do |world|
      setup_world(world)
    end
  end

  def worlds
    @paths_to_read.each { |path| RabbitMQSpec::Setup::WorldFetcher.call(path) }
  end

  def setup_world(world)
    RabbitMQSpec::Setup::WorldSetupper.call(world, @client)
  end
end
