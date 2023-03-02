require_relative 'base_api'

module YoutubeApi
  class GetChannelsInfo < BaseApi
    def call(channel_ids)
      return {} if channel_ids.empty?

      list_channels(channel_ids)
    end

    private

    def list_channels(channel_ids)
      youtube.list_channels('statistics, snippet, brandingSettings', id: channel_ids)
    end
  end
end
