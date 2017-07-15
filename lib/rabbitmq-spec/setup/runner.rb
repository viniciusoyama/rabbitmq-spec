# @api private
# Read each file and setups RabbitMQ based on
# each mqspec defined on them
# @example
#   RabbitMQSpec::Setup::Runner.run(
#      [
#        '/my/path/folde1',
#        'my/direct_mqspec/file.rb']
#      ], bunny_client)
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

  # private methods 
  private def worlds
    @paths_to_read.map { |path| RabbitMQSpec::Setup::WorldFetcher.call(path) }
  end

  private def setup_world(world)
    RabbitMQSpec::Setup::WorldSetupper.call(world, @client)
  end
end
