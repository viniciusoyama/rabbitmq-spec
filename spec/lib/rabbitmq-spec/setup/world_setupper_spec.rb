require 'spec_helper'

describe RabbitMQSpec::Setup::WorldSetupper do
  subject { RabbitMQSpec::Setup::WorldSetupper }

  describe '.call' do
    it "calls setup_exchange for each exchange" do
      world = RabbitMQSpec::DSL::World.new
      client = double('client')
      exchange1 = double('exchange1')
      exchange2 = double('exchange2')
      world.instance_variable_set('@exchanges', [exchange1, exchange2])

      expect(subject).to receive(:setup_exchange).with(exchange1, client).ordered
      expect(subject).to receive(:setup_exchange).with(exchange2, client).ordered

      subject.(world, client)
    end
  end

  describe '.setup_exchange' do
    before(:each) do
      @exchange = RabbitMQSpec::Entity::Exchange.new
      @exchange.name = 'exc1'
      @exchange.options = { exchange1_options: 'ex1opt' }

      @queue1 = RabbitMQSpec::Entity::Queue.new
      @queue1.name = "q1name"
      @queue1.routing_key = "q1.binding"
      @queue1.options = { queue1_options: 'q1opt' }

      @queue2 = RabbitMQSpec::Entity::Queue.new
      @queue2.name = "q2name"
      @queue2.routing_key = "q2.binding"
      @queue2.options = { queue2_options: 'q2opt' }

      @exchange.instance_variable_set('@queues', [@queue1, @queue2])
    end

    it "creates the exchange, the queues and the bindings. Ordered." do
      client = double('client')

      expect(client).to receive(:exchange).with('exc1', { exchange1_options: 'ex1opt' }).ordered
      expect(client).to receive(:queue).with('q1name', { queue1_options: 'q1opt' }).ordered
      expect(client).to receive(:queue).with('q2name', { queue2_options: 'q2opt' }).ordered

      subject.setup_exchange(@exchange, client)
    end
  end
end
