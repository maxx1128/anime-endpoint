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

  def download_images
    FileUtils.mkdir_p('downloads') unless Dir.exists?('downloads')

    @image_limit.times do
      tags = random_tag_groups.sample[:tags]
      image = WallpaperUrlQuery.new(tags).random_image
      random_number = Random.rand(9999999999)

      begin
      Timeout::timeout(10) do
        #do something here to get $results
      File.write "downloads/#{random_number}-image.jpg", URI.open(image).read
    end
      rescue Timeout::Error
        next # although I am not sure why this is needed.
      end
    end
  end

  def image_group
    image_urls = []

    @image_limit.times do
      tags = random_tag_groups.sample[:tags]
      image_urls.push(WallpaperUrlQuery.new(tags).random_image)
    end

    image_urls
  end
end
