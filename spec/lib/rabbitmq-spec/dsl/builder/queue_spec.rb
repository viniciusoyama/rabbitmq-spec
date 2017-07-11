# frozen_string_literal: true

require 'spec_helper'

describe RabbitMQSpec::DSL::Builder::Queue do
  describe '#build' do
    it 'builds and queue entity' do
      queue = described_class.build(name: 'queue-name') do
        description 'my-desc'
        routing_key 'routing.key'
        options do
          durable true
        end
      end
      expect(queue).to be_an_instance_of(RabbitMQSpec::Entity::Queue)
      expect(queue.name).to eq('queue-name')
      expect(queue.description).to eq('my-desc')
      expect(queue.routing_key).to eq('routing.key')
      expect(queue.options).to eq(durable: true)
    end
  end
end
