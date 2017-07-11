require 'spec_helper'

describe RabbitMQSpec::DSL::Builder::Exchange do
  describe '#build' do
    it 'builds and exchange entity' do
      exchange = described_class.build(name: 'exchange-name') do
        description 'my-exchange-desc'
        options do
          durable true
          attr_custom 3
        end
      end

      expect(exchange).to be_an_instance_of(RabbitMQSpec::Entity::Exchange)
      expect(exchange.name).to eq('exchange-name')
      expect(exchange.description).to eq('my-exchange-desc')
      expect(exchange.options).to eq({durable: true, attr_custom: 3})

    end

    it 'allows me to add queues to the exchange' do
      mock_queue = double('queue')
      allow(RabbitMQSpec::DSL::Builder::Queue).to receive(:build).and_return(mock_queue)
      exchange = described_class.build(name: 'exchange-name') do

        queue 'q1' do
          command1 '..'
          command2 '..'
          command3 '..'
        end

        queue 'q2' do
          command1 '..'
          command2 '..'
          command3 '..'
        end
      end
      expect(exchange.queues.count).to be(2)
      expect(exchange.queues[0]).to be(mock_queue)
      expect(exchange.queues[1]).to be(mock_queue)
    end
  end
end