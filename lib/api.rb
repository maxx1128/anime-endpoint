require 'sinatra'
require "sinatra/json"
require "sinatra/reloader"
require_relative 'wallpaper_url_query.rb'
require_relative 'api_params_bridge.rb'

get '/' do
  parameters = APIParamsBridge.new(params)
  tags = parameters.give_tags
  image_url = WallpaperUrlQuery.new(tags).random_image

  redirect image_url
end

get '/url/' do
  headers \
    "Access-Control-Allow-Origin"   => "*"

  parameters = APIParamsBridge.new(params)
  tags = parameters.give_tags
  image_url = WallpaperUrlQuery.new(tags).random_image

  json url: image_url
end
