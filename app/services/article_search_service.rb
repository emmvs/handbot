# frozen_string_literal: true

require 'httparty'
require 'json'

# Handles fetching and searching articles from HBG Article API
class ArticleSearchService
  include HTTParty
  API_BASE_URI = ENV['API_BASE_URI']
  API_CREDENTIALS = { username: ENV['API_USERNAME'], password: ENV['API_PASSWORD'] }.freeze

  def self.fetch_articles
    response = HTTParty.get(API_BASE_URI, basic_auth: API_CREDENTIALS)
    JSON.parse(response.body)['data'] || []
  end

  def self.search_by_keyword(keyword)
    matches = fetch_articles.select do |article|
      article_matches_keyword?(article, keyword)
    end
    format_articles(matches)
  end

  def self.article_matches_keyword?(article, keyword)
    keyword = keyword.downcase
    [article['title'], article['subtitle'], article['body']].compact.any? do |text|
      text.downcase.include?(keyword)
    end
  end

  def self.format_articles(articles)
    articles.map do |article|
      {
        title: article['title'],
        subtitle: article['subtitle'],
        link: "https://handbookgermany.de#{article['sourceUrl']}"
      }
    end
  end
end

# User interaction for testing the service
if $PROGRAM_NAME == __FILE__
  puts 'Enter a keyword to search:'
  keyword = gets.chomp
  results = ArticleSearchService.search_by_keyword(keyword)
  puts 'Search results:'
  puts results.inspect
end
