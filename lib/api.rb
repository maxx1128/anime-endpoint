require 'sinatra'
require "sinatra/reloader"
require_relative 'wallpaper_url_query.rb'
require_relative 'api_params_bridge.rb'

get '/' do
  parameters = APIParamsBridge.new(params)
  tags = parameters.give_tags
  image_url = WallpaperUrlQuery.new(tags).random_image

  "<img src=#{image_url} />"
end
