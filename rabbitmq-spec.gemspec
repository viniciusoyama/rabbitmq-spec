# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rabbitmq-spec/version'

Gem::Specification.new do |spec|
  spec.name          = 'rabbitmq-spec'
  spec.version       = RabbitMQSpec::VERSION
  spec.authors       = ['Vinicius Oyama']
  spec.email         = ['vinicius.oyama@codus.com.br']

  spec.summary       = 'Gem for documenting and configuring RabbitMQ brokers.'
  spec.description   = "Use this gem DSL to create RabbitMQ architecture specification and evaluate it in order to configure RabbitMQ in one shot."
  spec.homepage      = 'https://github.com/viniciusoyama/rabbitmq-spec'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'cri'
  spec.add_runtime_dependency 'bunny'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop', '0.49'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
