require 'spec_helper'
require 'bunny'

describe RabbitMQSpec::Setup do
  subject { RabbitMQSpec::Setup }
  describe '.run' do
    it 'calls setup runner within a client' do
      client = double('client')
      expect(subject).to receive(:with_client).with('url').and_yield(client)

      mock_runner = double('runner', run: true)
      expect(mock_runner).to receive(:run)

      expect(RabbitMQSpec::Setup::Runner).to receive(:new).with('PATHS_ARRAY', client).and_return(mock_runner)

      subject.run(files_paths: 'PATHS_ARRAY', url: 'url')
    end
  end

  describe '.with_client' do
    it 'yields a channel' do
      mock_channel = double('channel', close: true)
      mock_bunny = double('bunny', start: true, create_channel: mock_channel, close: true)
      expect(mock_bunny).to receive(:start)

      expect(Bunny).to receive(:new).with('url', automatically_recover: false).and_return(mock_bunny)

      subject.with_client('url') do |channel|
        expect(channel).to be(mock_channel)
      end
    end

    it 'ensures the channel and client closing' do
      mock_channel = double('channel', close: true)
      mock_bunny = double('bunny', start: true, create_channel: mock_channel, close: true)
      expect(mock_bunny).to receive(:start)

      expect(Bunny).to receive(:new).with('url', automatically_recover: false).and_return(mock_bunny)

      expect(mock_bunny).to receive(:close)
      expect(mock_channel).to receive(:close)

      subject.with_client('url') do |channel|
        raise 'Error'
      end
    end
  end
end
