rabbitmq-spec
==========
[![Travis](https://travis-ci.org/viniciusoyama/rabbitmq-spec.svg?branch=master)](https://travis-ci.org/viniciusoyama/rabbitmq-spec)
[![Code Climate](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec/badges/gpa.svg)](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec)
[![Test Coverage](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec/badges/coverage.svg)](https://codeclimate.com/github/viniciusoyama/rabbitmq-spec)

Gem for documenting and configuring RabbitMQ brokers

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'rabbitmq-spec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rabbitmq-spec

## Usage

### Creating RabbitMQ Specifications

1) Make a new folder and put your RabbitMQ Specification there. You can use the following syntax:

`````ruby

  exchange 'exchange-name' do
    description 'exchange-description' # optional

    # exchange options are fowarded to Bunny Channel#exchanged method
    # http://reference.rubybunny.info/Bunny/Channel.html#exchange-instance_method
    options do
      durable true
    end

    queue 'queue-name' do
      description 'queue1 description' # optional
      routing_key 'my-custom-routing-key' # optional

      # queue options are fowarded to Bunny Channel#queue method
      # http://reference.rubybunny.info/Bunny/Channel.html#queue-instance_methodChannel.html#exchange-instance_method
      options do
        durable true
      end
    end
  end
`````

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rabbitmq-spec.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
