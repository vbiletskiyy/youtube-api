require 'spec_helper'
require './services/youtube_api/get_parse_data'

describe YoutubeApi::GetParseData do
  let(:channel1) do
    Google::Apis::YoutubeV3::Channel.new(
      snippet: Google::Apis::YoutubeV3::ChannelSnippet.new(
        title: 'Channel 1',
        description: 'This is the description for channel 1. Email: test@test.com. Social links: https://twitter.com/test https://www.instagram.com/test/'
      ),
      statistics: Google::Apis::YoutubeV3::ChannelStatistics.new(
        subscriber_count: 1000,
        video_count: 50,
        view_count: 10000
      )
    )
  end

  let(:channel2) do
    Google::Apis::YoutubeV3::Channel.new(
      snippet: Google::Apis::YoutubeV3::ChannelSnippet.new(
        title: 'Channel 2',
        description: 'This is the description for channel 2. Social links: https://www.facebook.com/test https://www.linkedin.com/company/test https://www.tiktok.com/@test'
      ),
      statistics: Google::Apis::YoutubeV3::ChannelStatistics.new(
        subscriber_count: 5000,
        video_count: 100,
        view_count: 50000
      )
    )
  end

  let(:channels) { Google::Apis::YoutubeV3::ListChannelsResponse.new(items: [channel1, channel2]) }

  subject { described_class.new.call(channels) }

  it 'parses the channels data correctly' do
    expect(subject).to include(
      {
        title: 'Channel 1',
        description: 'This is the description for channel 1. Email: test@test.com. Social links: https://twitter.com/test https://www.instagram.com/test/',
        email: 'test@test.com',
        subscriber_count: 1000,
        video_count: 50,
        views_per_video: 200,
        social_links: [
          'https://twitter.com/test',
          'https://www.instagram.com/test',
        ]
      },
      {
        title: 'Channel 2',
        description: 'This is the description for channel 2. Social links: https://www.facebook.com/test https://www.linkedin.com/company/test https://www.tiktok.com/@test',
        email: '',
        subscriber_count: 5000,
        video_count: 100,
        views_per_video: 500,
        social_links: [
          'https://www.facebook.com/test',
          'https://www.linkedin.com/company/test',
          'https://www.tiktok.com/@test'
        ]
      }
    )
  end
end
