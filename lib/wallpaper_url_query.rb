require 'httparty'
require 'open-uri'
require 'nokogiri'
require_relative 'tags_module.rb'

class WallpaperUrlQuery
  include Tags
  BASE_URL = "https://safebooru.org/"

  def initialize(tags = random_tags[:tags], extra_params = '')
    @base_url = "#{BASE_URL}index.php?page=dapi&s=post&q=index&limit=1&tags=#{tags}#{extra_params}"
    @json_url = "#{@base_url}&json=1"
  end

  def random_image
    no_results ? WallpaperUrlQuery.new().random_image : get_image
  end

  private

  def no_results
    image_limit == 0
  end

  def error_message
    { error_message: 'No images here!' }
  end

  def image_limit
    page = Nokogiri::HTML.parse(URI.open(@base_url))
    page.css('posts').attribute('count').to_s.to_i
  end

  def random_post_integer
    rand(1..image_limit)
  end

  def random_image_response
    url = "#{@json_url}&pid=#{random_post_integer}"
    JSON.parse(HTTParty.get(url))[0]
  end

  def get_image
    r = random_image_response
    "#{BASE_URL}images/#{r['directory']}/#{r['image']}"
  end
end
