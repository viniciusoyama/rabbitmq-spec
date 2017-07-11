require 'spec_helper'

describe RabbitMQSpec::DSL do
  describe '.evaluate' do
    it 'evaluates the block in a DSL::World object and returns it' do
      world = described_class.evaluate do
        @___deep_custom_var_to_check = 'checkme'
      end
      expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
      expect(world.instance_variable_get('@___deep_custom_var_to_check')).to eq('checkme')
    end
  end
  # describe '.evaluate' do
  #   it 'evaluates the block in a DSL::World object and returns it' do
  #     world = described_class.evaluate do
  #     end
  #     expect(world).to be_an_instance_of(RabbitMQSpec::DSL::World)
  #   end

    # it "evaluates multiple exchanges and queues" do
    #   world = described_class.evaluate do
    #     exchange 'exchange1' do
    #       description 'exchange1-description'
    #       options do
    #         durable true
    #       end

    #       queue 'queue1' do
    #         description "queue1 description"
    #         routing_key 'my-custom-routing-key'
    #         options do
    #           durable true
    #           my_custom_option 'two'
    #         end
    #       end
    #     end

    #     exchange 'exchange2' do
    #       description 'exchange2-description'
    #       options do
    #         durable false
    #         ex1_option2 'test2'
    #       end

    #       queue 'queue3' do
    #         description "queue3 description"
    #         options do
    #           durable true
    #           my_custom_option 'two'
    #         end
    #       end

    #       queue 'queue2' do
    #         description "queue2 description"
    #         options do
    #           durable true
    #           my_custom_option 'two'
    #         end
    #       end
    #     end
    #   end

    #   expect(world.exchanges.count).to be(2)
    #   expect(world.exchanges[0].queues.count).to be(1)
    #   expect(world.exchanges[1].queues.count).to be(2)
    # end

  # end
end