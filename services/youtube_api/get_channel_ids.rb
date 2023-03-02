require_relative 'base_api'

module YoutubeApi
  class GetChannelIds < BaseApi
    def call(query)
      set_channel_ids(query)
    end

    private

    def set_channel_ids(query)
      channel_ids = []
      return channel_ids if query.empty?

      search_response = youtube.list_searches('snippet', q: query, type: 'video, channel', max_results: 50)
      search_response.items.each do |item|
        channel_ids << item.snippet.channel_id unless channel_ids.include?(item.snippet.channel_id)
      end
      channel_ids.join(',')
    end
  end
end
