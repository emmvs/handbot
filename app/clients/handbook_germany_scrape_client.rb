# frozen_string_literal: true

# The HandbookGermanyScrapeClient manages the scraping of articles
# from the Handbook Germany Website (and their search function)
# This client is responsible for constructing the appropriate search URL,
# performing the HTTP request to retrieve the search results page, and
# parsing the HTML response into a Nokogiri document for further processing.
#
# Example usage:
#   client = HandbookGermanyScrapeClient.new('keyword')
#   html_doc = client.fetch_articles
#
class HandbookGermanyScrapeClient
  BASE_URL = ENV['HANDBOOK_SEARCH_URI']

  def initialize(keyword)
    @keyword = keyword
  end

  # Fetches articles from the Handbook Germany website
  def fetch_articles
    search_url = build_search_url
    response = HTTParty.get(search_url)
    Nokogiri::HTML(response.body)
  end

  private

  # Constructs the search URL using the provided keyword
  def build_search_url
    "#{BASE_URL}?keys=#{@keyword}"
  end
end
