require_relative '../services/youtube_api/get_channel_ids'
require_relative '../services/youtube_api/get_channels_info'
require_relative '../services/youtube_api/get_parse_data'

class SearchController
  def self.find_channels(params)
    channel_ids = YoutubeApi::GetChannelIds.new.call(params)
    channels_info = YoutubeApi::GetChannelsInfo.new.call(channel_ids)
    channels_data = YoutubeApi::GetParseData.new.call(channels_info)

    {channels_data: channels_data}
  end
end
