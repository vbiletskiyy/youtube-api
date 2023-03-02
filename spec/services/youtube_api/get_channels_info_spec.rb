require 'spec_helper'
require 'vcr'
require './services/youtube_api/get_channels_info'

describe YoutubeApi::GetChannelsInfo do
  let(:channel_ids) { 'UCsXVk37bltHxD1rDPwtNM8Q,UCJowOS1R0FnhipXVqEnYU1A' }

  subject { described_class.new }

  it 'returns channel information for the specified channel ids' do
    VCR.use_cassette('channels_response') do
      channels_info = subject.call(channel_ids)
      expect(channels_info.items.count).to eq(2)
      expect([channels_info.items[0].id, channels_info.items[1].id]).to include('UCsXVk37bltHxD1rDPwtNM8Q', 'UCJowOS1R0FnhipXVqEnYU1A')
      expect(channels_info).to_not be_nil
    end
  end
end
