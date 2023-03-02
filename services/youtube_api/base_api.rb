require 'dotenv/load'
require 'google/apis/youtube_v3'

module YoutubeApi
  class BaseApi
    attr_reader :youtube

    def initialize
      @youtube = Google::Apis::YoutubeV3::YouTubeService.new
      @youtube.key = ENV['YOUTUBE_API_KEY']
    end
  end
end
