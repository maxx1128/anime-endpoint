require 'fileutils'
require_relative 'wallpaper_url_query.rb'

class WallpaperEmailPresenter
  def initialize
    @data = WallpaperQuery.new().get_image_urls
  end

  def full_view
    wallpaper_views.prepend("<h1>Here's Today's Wallpapers!</h1>")
  end

  private

  def wallpaper_views
    all_views = @data.map do |wallpaper|
      view = "<h3>#{wallpaper[:label]}</h3>"
      view << "<img src=#{wallpaper[:url]} style='display: block; max-width: 100%; margin: 0 auto;' />"
    end

    all_views.join('')
  end
end
