# frozen_string_literal: true

require 'httparty'
require 'open-uri'
require 'nokogiri'

# The ArticleScrapeService handles the scraping and searching of articles
# from the Handbook Germany website, providing a reliable fallback mechanism
# for retrieving content in case the API is unavailable
class ArticleScrapeService
  BASE_URL = ENV['HANDBOOK_SEARCH_URI']

  def self.scrape_articles(keyword)
    search_url = "#{BASE_URL}?keys=#{keyword}"
    response = HTTParty.get(search_url)
    html_doc = Nokogiri::HTML(response.body)
    extract_articles(html_doc)
  end

  def self.extract_articles(html_doc)
    articles = []
    html_doc.css('.teaser-content').each do |teaser|
      title = teaser.css('h4').text.strip if teaser.css('h4').any?
      link_elements = teaser.parent.css('.teaser-links div a')
      link = link_elements.first['href'] if link_elements.any?
      articles << { title: title, link: "https://handbookgermany.de#{link}" } if title && link
    end
    articles
  end
end

# Example of using the service
if $PROGRAM_NAME == __FILE__
  puts 'Enter a keyword to search:'
  keyword = gets.chomp
  results = ArticleScrapeService.scrape_articles(keyword)
  puts 'Search results:'
  puts results.inspect
end
