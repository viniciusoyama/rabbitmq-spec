require 'spec_helper'

describe RabbitMQSpec::DSL do
  describe '.evaluate' do
    it 'evaluates the block in a DSL::World object and returns it' do
      world = described_class.evaluate do
      end
      expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
    end
  end
end