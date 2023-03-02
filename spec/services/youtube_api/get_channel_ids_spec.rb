require 'vcr'
require 'webmock/rspec'
require './services/youtube_api/get_channel_ids'

RSpec.describe YoutubeApi::GetChannelIds do
  let(:query) { 'cats' }

  it 'returns a comma-separated string of unique channel IDs' do

    VCR.use_cassette('search_channels') do
      result = described_class.new.call(query)

      expect(result).not_to be_nil
    end
  end
end
