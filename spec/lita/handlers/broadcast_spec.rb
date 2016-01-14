require 'spec_helper'

describe Lita::Handlers::Broadcast, lita_handler: true do
  it { is_expected.to route_command('tell #channel1: hello').to(:broadcast) }
  it { is_expected.to route_command('tell #channel1 C2: hello').to(:broadcast) }

  describe '#broadcast' do
    let(:user1) { Lita::User.create('U1', name: 'User1', mention_name: 'user1') }
    let(:channel1) { Lita::Room.create_or_update('C1', name: 'channel1') }
    let(:channel2) { Lita::Room.create_or_update('C2', name: 'channel2') }

    it 'sends the message to multiple targets' do
      expect(Lita::Room).to receive(:fuzzy_find).with('#channel1').and_return(channel1)
      expect(Lita::Room).to receive(:fuzzy_find).with('C2').and_return(channel2)
      expect(robot).to receive(:send_message).with(instance_of(Lita::Source), 'user1 says: hello').twice
      send_command('tell #channel1 C2: hello', as: user1)
    end

    it 'replies with an error if a given channel does not exist' do
      send_command('tell #channel3: hello', as: user1)
      expect(replies.count).to eq(1)
      expect(replies.last).to eq("Channel '#channel3' does not exist.")
    end
  end
end
