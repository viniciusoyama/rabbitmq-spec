module RabbitMQSpec::Setup::WorldFetcher
  class << self
    def call(mqspec_file_path)
      dsl_string = File.read(mqspec_file_path)
      RabbitMQSpec::DSL.evaluate(dsl_string)
    end
  end
end
