require 'sinatra'
require 'google/apis/youtube_v3'
require_relative './controllers/search_controller'

get '/' do
  erb :search_form
end

post '/' do
  search_result = SearchController.find_channels(params[:query])
  @channels_data = search_result[:channels_data]

  erb :index
end

