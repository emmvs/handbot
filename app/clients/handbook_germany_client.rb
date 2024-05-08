# frozen_string_literal: true

# The HandbookGermanyClient manages the retrieval and keyword-based fetching
# of articles through the Handbook Germany Article API
class HandbookGermanyClient
  include HTTParty
  API_BASE_URI = ENV['API_BASE_URI']
  API_CREDENTIALS = { username: ENV['API_USERNAME'], password: ENV['API_PASSWORD'] }.freeze

  def fetch_articles
    HTTParty.get(API_BASE_URI, basic_auth: API_CREDENTIALS)
  end
end
