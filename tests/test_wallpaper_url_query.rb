require "test/unit"
require_relative '../lib/wallpaper_url_query.rb'

class TestWallpaperUrlQuery < Test::Unit::TestCase

  def test_gets_data
    urls = query.get_image_urls
    assert_equal(urls.any?, true)
  end

  private

  def query
    WallpaperQuery.new()
  end
end
