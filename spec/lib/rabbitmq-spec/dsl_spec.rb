require 'spec_helper'

describe RabbitMQSpec::DSL do
  describe '.evaluate' do
    it 'evaluates the string in a DSL::World object and returns it' do
      world = described_class.evaluate %(
        @___deep_custom_var_to_check = 'checkme'
      )
      expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
      expect(world.instance_variable_get('@___deep_custom_var_to_check')).to eq('checkme')
    end
  end
end
