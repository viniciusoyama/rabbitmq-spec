require 'spec_helper'

describe RabbitMQSpec::Setup::Runner do
  describe '#initialize' do
    it 'stores the paths' do
      runner = RabbitMQSpec::Setup::Runner.new('path', 'client')
      expect(runner.instance_variable_get('@paths_to_read')).to eq('path')
    end

    it 'stores the client' do
      runner = RabbitMQSpec::Setup::Runner.new('path', 'client')
      expect(runner.instance_variable_get('@client')).to eq('client')
    end
  end

  describe '#run' do
    it 'calls setup_world for each world' do
      world1 = double('world1')
      world2 = double('world2')
      world3 = double('world3')
      client = double('client')

      runner = RabbitMQSpec::Setup::Runner.new(['path1', 'path2', 'path3..'], client)

      expect(runner).to receive(:worlds).and_return([world1, world2, world3])
      expect(runner).to receive(:setup_world).with(world1).ordered
      expect(runner).to receive(:setup_world).with(world2).ordered
      expect(runner).to receive(:setup_world).with(world3).ordered

      runner.run
    end
  end

  describe '#setup_world' do
    it 'runs the WorldSetupper' do
      world = double('world')
      client = double('client')
      runner = RabbitMQSpec::Setup::Runner.new(['path1', 'path2', 'path3..'], client)

      expect(RabbitMQSpec::Setup::WorldSetupper).to receive(:call).with(world, client)

      runner.setup_world(world)
    end
  end


  describe '#worlds' do
    it 'runs the WorldFetchers' do
      world = double('world')
      client = double('client')
      runner = RabbitMQSpec::Setup::Runner.new(['path1', 'path2', 'path3..'], client)

      expect(RabbitMQSpec::Setup::WorldFetcher).to receive(:call).with(['path1', 'path2', 'path3..'])

      runner.worlds
    end
  end
end
