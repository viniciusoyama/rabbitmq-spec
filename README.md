rabbitmq-spec
==========
[![Travis](https://travis-ci.org/viniciusoyama/rabbitmq-spec.svg?branch=master)](https://travis-ci.org/viniciusoyama/rabbitmq-spec)
[![Code Climate](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec/badges/gpa.svg)](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec)
[![Test Coverage](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec/badges/coverage.svg)](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec)

Gem for documenting and configuring RabbitMQ.

It uses the specification files themselves to setup all the exchanges, queues and bindings on RabbitMQ.

# Installation

Add this line to your application's Gemfile:

```ruby

gem 'rabbitmq-spec'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rabbitmq-spec

# Usage

## Specification files

You can document your RabbitMQ architecture using this gem DSL.

We suggest to make a new folder called mqspecs and put your RabbitMQ Specification there. You can define everything in one file or split in many files/subfolders.

Example:

```

├── my_app/
│   ├── ...
├── mqspecs/
│   ├── exchange1_mqspec.rb
│   ├── exchange2_mqspec.rb
│   ├── ...

```

On each mqspec file. You can use the following syntax:

`````ruby

  exchange 'exchange-name' do
    description 'exchange-description' # optional

    # exchange options are forwarded to Bunny Channel#exchanged method
    # http://reference.rubybunny.info/Bunny/Channel.html#exchange-instance_method
    options do
      type 'topic'
      durable true
    end

    queue 'queue-name' do
      description 'queue1 description' # optional
      routing_key 'my-custom-routing-key' # optional

      # queue options are forwarded to Bunny Channel#queue method
      # http://reference.rubybunny.info/Bunny/Channel.html#queue-instance_methodChannel.html#exchange-instance_method
      options do
        durable true
      end
    end
  end
`````

## RabbitMQ Setup

To understand how to use rabbitmq-spec just type the following on your shell after installing the gem:

```shell

rabbitmq-spec

```

It will list all the available commands and how to use them. Example:

```

$ rabbitmq-spec
USAGE
    rabbitmq-spec command [options]

COMMANDS
    setup     
    Usage: rabbitmq-spec setup ./mqspec [-u 'amqp://guest:guest@localhost:5672']
    Configure RabbitMQ using the mqspecs files.
    If you pass a ruby file it will evaluate it.
    If you pass a folder it will look for all the files finishing with "_mqspec.rb" and evaluate them.


OPTIONS
    -h --help      show help for rabbitmq-spec

```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

No additional configuration is needed.

Here we're using Rspec with simplecov and rubocop.

## Contributing

If you have any idea for a feature or have found any bugs feel free to open a new issue at:

https://github.com/viniciusoyama/rabbitmq-spec.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
