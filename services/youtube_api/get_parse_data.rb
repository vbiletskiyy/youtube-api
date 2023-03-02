require_relative 'base_api'

module YoutubeApi
  class GetParseData < BaseApi
    EMAIL_REGEX = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/
    SOCIAL_NETWORK_REGEXES = {
      facebook: /https?:\/\/(www\.)?facebook.com\/[a-zA-Z0-9_\.]+/,
      twitter: /https?:\/\/(www\.)?twitter.com\/[a-zA-Z0-9_]+/,
      instagram: /https?:\/\/(www\.)?instagram.com\/[a-zA-Z0-9_\.]+/,
      linkedin: /https?:\/\/(www\.)?linkedin.com\/company\/[a-zA-Z0-9_]+/,
      tiktok: /https?:\/\/(www\.)?tiktok\.com\/(@[a-zA-Z0-9_.]+)\/?/,
      telegram: /https?:\/\/(www\.)?t.me\/[a-zA-Z0-9_]+/,
    }

    def call(channels)
      parse_date(channels)
    end

    private

    def parse_date(channels)
      channels_data = []

      if channels.respond_to?(:items) && !channels.items.nil?
        channels.items.each do |channel|
          channel_data = {}
          channel_data[:title] = channel.snippet.title
          channel_data[:description] = channel.snippet.description
          description = channel_data[:description]
          email = description.match(EMAIL_REGEX).to_s
          channel_data[:email] = email.empty? ? '' : email
          channel_data[:subscriber_count] = channel.statistics.subscriber_count
          channel_data[:video_count] = channel.statistics.video_count
          channel_data[:views_per_video] = channel.statistics.view_count / channel_data[:video_count]
          SOCIAL_NETWORK_REGEXES.each do |network, regex|
            match = description.match(regex)
            if match
              channel_data[:social_links] ||= []
              channel_data[:social_links] << match[0]
            end
          end
          channels_data << channel_data
        end
        channels_data
      else
        channels_data
      end
    end
  end
end
