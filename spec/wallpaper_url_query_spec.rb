require_relative '../lib/wallpaper_url_query.rb'

describe WallpaperUrlQuery do
  before :each do
    @query = WallpaperUrlQuery.new()
  end

  it 'should return URLs' do
    urls = @query.get_image_urls
    expect(urls).not_to be_empty
  end
end
