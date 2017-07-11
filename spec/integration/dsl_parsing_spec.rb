require 'spec_helper'

describe "DSL Parsing should store all configurations" do
  specify do

    world = RabbitMQSpec::DSL.evaluate do
      exchange 'exchange1' do
        description 'exchange1-description'

        options do
          durable true
        end

        queue 'queue1' do
          description "queue1 description"
          routing_key 'my-custom-routing-key'
          options do
            durable true
            my_custom_option 'two'
          end
        end
      end

      exchange 'exchange2' do
        description 'exchange2-description'
        options do
          durable false
          ex1_option2 'test2'
        end

        queue 'queue3' do
          description "queue3 description"
          options do
            durable true
            my_custom_option 'two'
          end
        end

        queue 'queue2' do
          description "queue2 description"
          options do
            durable true
            my_custom_option 'two'
          end
        end
      end
    end

    expect(world.exchanges.count).to be(2)

    # exchange 1
    expect(world.exchanges[0].name).to eq('exchange1')
    expect(world.exchanges[0].description).to eq('exchange1-description')
    expect(world.exchanges[0].options).to eq({durable: true})
    expect(world.exchanges[0].queues.count).to be(1)
    expect(world.exchanges[0].queues[0].name).to eq('queue1')
    expect(world.exchanges[0].queues[0].description).to eq('queue1 description')
    expect(world.exchanges[0].queues[0].routing_key).to eq('my-custom-routing-key')
    expect(world.exchanges[0].queues[0].options).to eq({durable: true, my_custom_option: 'two'})

    # exchange 2
    expect(world.exchanges[1].queues.count).to be(2)
  end
end