require 'spec_helper'

describe RabbitMQSpec::Setup::Runner do
  describe '#run' do
    it 'calls setup_world for each world' do
      world1 = double('world1')
      world2 = double('world2')
      world3 = double('world3')

      runner = RabbitMQSpec::Setup::Runner.new(['path1', 'path2', 'path3..'])

      expect(runner).to receive(:worlds).and_return([world1, world2, world3])
      expect(runner).to receive(:setup_world).with(world1).ordered
      expect(runner).to receive(:setup_world).with(world2).ordered
      expect(runner).to receive(:setup_world).with(world3).ordered

      runner.run
    end
  end
end
