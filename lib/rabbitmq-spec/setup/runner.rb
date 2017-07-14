class RabbitMQSpec::Setup::Runner
  def initialize(paths_to_read)
    @paths_to_read = paths_to_read
  end

  def run
    worlds.each do |world|
      setup_world(world)
    end
  end

  def worlds
  end

  def setup_world(world)
  end
end
