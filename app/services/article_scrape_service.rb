# frozen_string_literal: true

# The ArticleScrapeService handles the scraping and searching of articles
# from the Handbook Germany website, providing a reliable fallback mechanism
# for retrieving content in case the API is unavailable.
#
# Example usage:
#   service = ArticleScrapeService.new('keyword')
#   articles = service.call
#
# Public Methods:
#   - call: Initiates the scraping process and returns the extracted articles.
#
# Private Methods:
#   - scrape_articles: Performs the HTTP request and parses the HTML response
#   - extract_articles: Extracts article titles and links from the parsed HTML
#   - extract_title: Extracts the title from a given teaser element
#   - extract_link: Extracts the link from a given teaser element
#   - build_full_link: Constructs the full URL for an article link
class ArticleScrapeService < ApplicationService
  BASE_URL = ENV['HANDBOOK_SEARCH_URI']

  def initialize(keyword)
    super()
    @keyword = keyword
    @client = HandbookGermanyScrapeClient.new(keyword)
  end

  def call
    scrape_articles
  end

  private

  def scrape_articles
    html_doc = @client.fetch_articles
    extract_articles(html_doc)
  end

  def extract_articles(html_doc)
    articles = []
    html_doc.css('.teaser-content').each do |teaser|
      title = extract_title(teaser)
      link = extract_link(teaser)
      articles << { title:, link: build_full_link(link) } if title && link
    end
    articles
  end

  def extract_title(teaser)
    teaser.css('h4').text.strip if teaser.css('h4').any?
  end

  def extract_link(teaser)
    link_elements = teaser.parent.css('.teaser-links div a')
    link_elements.first['href'] if link_elements.any?
  end

  def build_full_link(link)
    "https://handbookgermany.de#{link}"
  end
end
