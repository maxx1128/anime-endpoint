require_relative '../lib/wallpaper_url_query.rb'

describe WallpaperUrlQuery do
  let(:query) { WallpaperUrlQuery.new() }

  it 'should return an image url' do
    image = query.random_image

    expect(image).to be_a(String)
    expect(image).to include(WallpaperUrlQuery::BASE_URL)
    expect(image).to include('.jpg').or include('.png')
  end

  it 'should give different images from the same object' do
    image1 = query.random_image
    image2 = query.random_image

    expect(image1).not_to eq(image2)
  end

  context 'when no result can be found' do
    impossible_tags = {
      name: "No Results",
      tags: "+nothing+false+impossible+empty+leijfoqd" }

    let(:query) { WallpaperUrlQuery.new(impossible_tags) }

    it 'returns a hash notifying there is nothing' do
      result = query.random_image
      message = result[:error_message]

      expect(result).to include(:error_message)
      expect(message).to be_a(String)
    end
  end
end
