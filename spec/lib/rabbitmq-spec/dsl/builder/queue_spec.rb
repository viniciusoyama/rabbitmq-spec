require 'spec_helper'

describe RabbitMQSpec::DSL::Builder::Queue do
  describe '#build' do
    it 'saves the configured options to the entity' do
      queue = described_class.build(name: 'exchange-name') do
        description 'my-desc'
        random_method 'random_value'
      end
      expect(queue).to be_an_instance_of(RabbitMQSpec::Entity::Queue)

    end
  end
end