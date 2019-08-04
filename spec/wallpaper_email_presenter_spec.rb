require 'nokogiri'
require_relative '../lib/wallpaper_email_presenter.rb'
require_relative '../lib/tags_module.rb'

describe WallpaperEmailPresenter do
  include Tags

  let(:presenter) { WallpaperEmailPresenter.new() }
  let(:markup) { Nokogiri::HTML.parse(presenter.full_view) }
  let(:all_random_tags) { [random_tags, random_tags] }

  before :each do
    allow(presenter).to receive(:random_tag_groups).and_return(all_random_tags)
  end

  it 'should have a title' do
    number_of_headers = markup.css('h1').length
    expect(number_of_headers).to eq(1)
  end

  it 'should have valid images' do
    all_images = markup.css('img')
    expect(all_images.length).to eq(all_random_tags.length)

    all_images.each do |img|
      src = img.attribute('src').to_s
      expect(src).to be_truthy
      expect(src).to include('.png').or include('.jpg')
    end
  end

  it 'should have an equal number of subheaders and images' do
    number_of_images = markup.css('img').length
    number_of_subheaders = markup.css('h3').length

    expect(number_of_images).to eq(number_of_subheaders)
  end

  context 'if a tag returns no image' do
    it 'should have an error message for only those images' do
      impossible_tags = {
        name: "No Results",
        tags: "+nothing+false+impossible+empty+qwkefjqiwdiqwhud"
      }
      allow(presenter).to receive(:random_tag_groups).and_return([random_tags, impossible_tags])

      number_of_images = markup.css('img').length
      number_of_errors = markup.css('.error-message').length
      expect(number_of_images).to eq(1)
      expect(number_of_errors).to eq(1)
    end
  end
end
