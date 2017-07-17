require 'spec_helper'

describe RabbitMQSpec::DSL::World do
  describe '#exchange' do
    it 'adds a exchange entity to exchange array' do
      mock_exchange = double('exchange')
      expect(RabbitMQSpec::DSL::Builder::Exchange).to receive(:build).and_return(mock_exchange)
      builded_exchange = subject.exchange('name') do
      end
      expect(subject.exchanges[0]).to be(mock_exchange)
    end
  end
  describe '#queue' do
    it 'adds a queue entity to single_queues array' do
      mock_single_queue = double('single_queue')
      expect(RabbitMQSpec::DSL::Builder::Queue).to receive(:build).and_return(mock_single_queue)
      builded_single_queue = subject.queue('name') do
      end
      expect(subject.single_queues[0]).to be(mock_single_queue)
    end
  end
end
