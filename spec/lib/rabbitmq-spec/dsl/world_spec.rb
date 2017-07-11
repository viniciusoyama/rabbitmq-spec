# frozen_string_literal: true

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
end
