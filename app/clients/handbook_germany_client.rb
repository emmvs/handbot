# frozen_string_literal: true

# Client for fetching articles from the Handbook Germany API.
# It handles the retrieval of all articles paginated by the API and handles basic HTTP authentication
# 
# Example usage:
#   user = User.new(language_code: 'en')
#   client = HandbookGermanyClient.new(user)
#   articles = client.fetch_articles
# 
# Methods:
#   - fetch_articles: Retrieves all articles, handling pagination
#   - initialize: Initializes the client with a user
# 
# Private methods:
#   - request_articles: Performs an HTTP GET request for a specific page of articles API
#   - add_articles_from_response: Processes the response to extract and add articles
#   - parse_response: Safely parses JSON response
#   - log_error: Logs errors for failed HTTP requests
#   - log_fetch_completion: Logs completion of the fetch operation
#   - user_language: Retrieves the user's preferred language code
class HandbookGermanyClient
  include HTTParty
  API_BASE_URI = ENV['API_BASE_URI']
  API_CREDENTIALS = { username: ENV['API_USERNAME'], password: ENV['API_PASSWORD'] }.freeze

  def initialize(user)
    @user = user
  end

  # Fetch all articles from the API, handling pagination.
  def fetch_articles # rubocop:disable Metrics/MethodLength
    articles = []
    page = 1
    total_pages = nil

    while total_pages.nil? || page <= total_pages
      response = request_articles(page)
      break unless response && add_articles_from_response(articles, response)

      total_pages = response['meta']['pages']
      page += 1
    end

    log_fetch_completion(articles)
    articles
  end

  private

  def request_articles(page)
    base_uri = "#{API_BASE_URI}/#{user_language}/api/v1/articles"
    response = HTTParty.get(base_uri, query: { page: page }, basic_auth: API_CREDENTIALS)
    log_error(response) unless response.success?
    response.success? ? response : nil
  end

  # Extract articles from response and check if pagination should continue
  def add_articles_from_response(articles, response)
    parsed_response = parse_response(response.body)
    return false unless parsed_response

    articles.concat(parsed_response['data'].reject(&:empty?))
    true
  end

  def parse_response(body)
    JSON.parse(body)
  rescue JSON::ParserError => e
    puts "JSON parsing error: #{e.message}"
    nil
  end

  def log_error(response)
    puts "Error fetching articles: #{response.code} #{response.body}"
  end

  def log_fetch_completion(articles)
    puts "🗞️🗞️🗞️ Total articles fetched: #{articles.count}"
  end

  def user_language
    @user.language_code
  end
end
