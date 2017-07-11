require 'spec_helper'

describe RabbitMQSpec::DSL do
  describe '.evaluate' do
    it 'evaluates the block in a DSL::World object and returns it' do
      world = described_class.evaluate do
      end
      expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
    end
  end
  describe '.evaluate' do
    it 'evaluates the block in a DSL::World object and returns it' do
      world = described_class.evaluate do
      end
      expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
    end

    it "evaluates multiple exchanges and queues" do
      world = described_class.evaluate do
        exchange 'exchange1', 'exchange1-description', ex1_option1: 'test', ex1_option2: 'test2' do
          queue 'queue1', "queue1 description", queue1_option1: 'queue1op1', queue1_option2: 'queue1dop1'
          queue 'queue2', "queue2 description", queue2_option1: 'queue2op1', queue2_option2: 'queue2dop1'
        end

        exchange 'exchange2', 'exchange2-description', ex2_option1: 'value1', ex2_option2: 'value2' do
          queue 'queue1', "queue1 description", queue1_option1: 'queue1op1', queue1_option2: 'queue1dop1'
          queue 'queue3', "queue3 description", queue3_option1: 'queue3op1', queue3_option2: 'queue2dop1'
          queue 'queue4', "queue4 description", queue4_option1: 'queue4op1', queue4_option2: 'queue2dop1'
        end
      end

      expect(world.exchanges.count).to be(2)
      expect(world.exchanges[0].queues.count).to be(2)
      expect(world.exchanges[1].queues.count).to be(3)
    end
  end
end