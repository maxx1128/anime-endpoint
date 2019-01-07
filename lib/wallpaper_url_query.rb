require 'open-uri'
require 'nokogiri'
require_relative 'tags_module.rb'

class WallpaperQuery
  include Tags
  BASE_URL = "http://safebooru.org/"
  IMAGE_NOT_FOUND_URL = "https://www.readjunk.com/wp-content/uploads/2015/09/no-image-found1-900x600.png"

  def get_image_urls
    all_image_params.each do |image|
      image[:url] = get_image_url(image[:params])
    end
  end

  private

  def get_image_url(tags = reading_params)
    url = "#{BASE_URL}index.php?page=post&s=list&tags=#{tags}"
    query_results_page = InitialResultsPage.new(url, tags)

    if query_results_page.has_multiple_pages?
      random_page = query_results_page.random_page_url
      RandomResultsPage.new(random_page).random_image
    else
      IMAGE_NOT_FOUND_URL
    end
  end

  InitialResultsPage = Struct.new(:url, :tags) do
    def page
      Nokogiri::HTML.parse(open(url))
    end

    def has_multiple_pages?
      page.css('.pagination a:last-of-type').any?
    end

    def total_pages
      last_page_href = page.css('.pagination a:last-of-type').attribute('href').to_s
      pid_limit = last_page_href.split('pid=')[1].to_i
    end

    def random_page_url
      possible_pages = (total_pages / 40)
      random_page_pid = rand(0..possible_pages) * 40
      "#{url}&pid=#{random_page_pid}"
    end
  end

  RandomResultsPage = Struct.new(:url) do
    def page
      Nokogiri::HTML.parse(open(url))
    end

    def all_results
      page.css('.content > div span a').map { |item| "#{BASE_URL}#{item.attribute('href')}" }
    end

    def random_image
      image_page_url = all_results.sample
      image_page = Nokogiri::HTML.parse(open(image_page_url))
      image_page.css('#image').attribute('src').to_s.sub('//safebooru.org/', BASE_URL)
    end
  end
end
