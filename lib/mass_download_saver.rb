require 'fileutils'
require 'open-uri'
require_relative 'tags_module.rb'
require_relative 'wallpaper_url_query.rb'

class MassDownloadSaver
  include Tags
  DEFAULT_NUMBER = 10

  def initialize(image_limit=DEFAULT_NUMBER)
    @image_limit = image_limit
  end

  def random_tag_groups
    [reading_tags, glasses_tags, happy_tags, sad_tags, outdoor_tags, absurdres_tags, random_tags]
  end

  def image_group
    image_urls = []

    @image_limit.times do
      tags = random_tag_groups.sample[:tags]
      image_urls.push(WallpaperUrlQuery.new(tags).random_image)
    end

    image_urls
  end

  def download_images
    FileUtils.mkdir_p('downloads') unless Dir.exists?('downloads')
    image_group.map do |image|
      random_number = Random.rand(9999999999)
      File.write "downloads/#{random_number}-image.jpg", open(image).read
    end
  end
end
