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

    it "calls setup_queue for each single_queue" do
      world = RabbitMQSpec::DSL::World.new
      client = double('client')
      queue1 = double('queue1')
      queue2 = double('queue2')
      world.instance_variable_set('@single_queues', [queue1, queue2])

      expect(subject).to receive(:setup_queue).with(queue1, client).ordered
      expect(subject).to receive(:setup_queue).with(queue2, client).ordered

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
      @queue2.options = { queue2_options: 'q2opt' }

      @exchange.instance_variable_set('@queues', [@queue1, @queue2])
    end

    it "creates the exchange, the queues and the bindings. Ordered." do
      client = double('client')

      expect(client).to receive(:exchange).with('exc1', { exchange1_options: 'ex1opt' }).ordered

      created_queue = double('queue1')
      expect(client).to receive(:queue).with('q1name', { queue1_options: 'q1opt' }).ordered.and_return(created_queue)
      expect(created_queue).to receive(:bind).with('exc1', routing_key: "q1.binding").ordered

      created_queue = double('queue2')
      expect(client).to receive(:queue).with('q2name', { queue2_options: 'q2opt' }).ordered.and_return(created_queue)
      expect(created_queue).to receive(:bind).with('exc1').ordered

      subject.setup_exchange(@exchange, client)
    end
  end


  describe '.setup_queue' do
    before(:each) do
      @queue1 = RabbitMQSpec::Entity::Queue.new
      @queue1.name = "q1name"
      @queue1.options = { queue1_options: 'q1opt' }
    end

    it "creates the queue and returns it" do
      client = double('client')
      mock_queue = double('queue1')

      expect(client).to receive(:queue).with('q1name', { queue1_options: 'q1opt' }).and_return(mock_queue).ordered

      queue = subject.setup_queue(@queue1, client)
      expect(queue).to be(mock_queue)
    end
  end
end
