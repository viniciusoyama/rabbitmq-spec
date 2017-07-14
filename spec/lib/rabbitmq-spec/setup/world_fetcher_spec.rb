require 'spec_helper'

describe RabbitMQSpec::Setup::WorldFetcher do
  subject { RabbitMQSpec::Setup::WorldFetcher }

  describe '.call' do
    it "evaluates a single file and returns the world in an array" do
      mock_world = double('world')
      expect(RabbitMQSpec::DSL).to receive(:evaluate).with(load_fixture('dsl_example.rb')).and_return(mock_world)

      world = subject.(fixture_path('dsl_example.rb'))

      expect(world).to be(mock_world)
    end
  end
end
