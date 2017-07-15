# @api private
# Given a file path it opens the file and
# evaluate its content using the DSL
# @example
#   RabbitMQSpec::Setup::WorldFetcher.('/my/file/path.rb')
module RabbitMQSpec::Setup::WorldFetcher
  class << self
    def call(mqspec_file_path)
      dsl_string = File.read(mqspec_file_path)
      RabbitMQSpec::DSL.evaluate(dsl_string)
    end
  end
end
