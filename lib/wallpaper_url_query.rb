require 'open-uri'
require 'nokogiri'
require_relative 'tags_module.rb'

class WallpaperUrlQuery
  include Tags
  BASE_URL = "http://safebooru.org/"

  def initialize(tags = random_tags[:tags], extra_params = '')
    url = "#{BASE_URL}index.php?page=post&s=list&tags=#{tags}#{extra_params}"
    @results_page = InitialResultsPage.new(url, tags)
  end

  def random_image
    if @results_page.has_any_pages?
      random_page = @results_page.random_page_url
      results_page = RandomResultsPage.new(random_page)

      results_page.random_image
    else
      { error_message: 'No images here!' }
    end
  end

  private

  InitialResultsPage = Struct.new(:url, :tags) do
    def page
      Nokogiri::HTML.parse(open(url))
    end

    def has_multiple_pages?
      page.css('.pagination a:last-of-type').any?
    end

    def has_any_pages?
      page.css('.pagination').any?
    end

    def total_pages
      last_page_href = page.css('.pagination a:last-of-type').attribute('href').to_s
      pid_limit = last_page_href.split('pid=')[1].to_i
    end

    def random_page_url
      if has_multiple_pages?
        possible_pages = (total_pages / 20)
        random_page_pid = rand(1..possible_pages) * 20
        (random_page_pid == 20) ? url : "#{url}&pid=#{random_page_pid}"
      else
        url
      end
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
