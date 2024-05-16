# frozen_string_literal: true

# Service to handle the search functionality for articles in the Handbot App
#
# This service fetches all articles from the Handbook Germany API and filters them based on a
# provided query keyword. The search is conducted in the article's title, subtitle, body,
# and any nested elements
#
# Example usage:
#   search_service = SearchService.new("anmeldung", user)
#   results = search_service.search
#   # => { query: "anmeldung", articles: [...] }
#
class SearchService
  def initialize(query, user)
    @query = query.downcase.strip
    @user = user
  end

  def search
    articles = fetch_api_articles
    return no_articles_found unless articles

    matching_results = filter_articles_by_keyword(articles)
    matching_results.empty? ? no_articles_found : format_search_results(matching_results)
  end

  private

  def fetch_api_articles
    client = HandbookGermanyApiClient.new(@user)
    client.fetch_articles
  end

  def filter_articles_by_keyword(articles)
    articles.map do |article|
      format_result(article) if article_matches_keyword?(article, @query)
    end.compact
  end

  def article_matches_keyword?(article, keyword)
    match_found = keyword_present_in_main_fields?(article, keyword)
    match_found ||= keyword_present_in_elements?(article['elements'], keyword)
    match_found
  end

  def keyword_present_in_main_fields?(article, keyword)
    [article['title'], article['subtitle'], article['body']].compact.any? do |field|
      extract_text(field).include?(keyword)
    end
  end

  def keyword_present_in_elements?(elements, keyword)
    elements&.any? do |element|
      extract_text_from_element(element).include?(keyword)
    end
  end

  def extract_text(html_content)
    return '' unless html_content

    Nokogiri::HTML(html_content).text.to_s.downcase.strip
  end

  def extract_text_from_element(element)
    return '' unless element

    element_texts = extract_element_texts(element)
    element_texts.compact.join(' ')
  end

  def extract_element_texts(element)
    case element
    when Hash
      extract_texts_from_hash(element)
    when Array
      element.flat_map { |sub_element| extract_text_from_element(sub_element) }
    else
      []
    end
  end

  def extract_texts_from_hash(element)
    element.flat_map do |key, value|
      if %w[body title].include?(key)
        extract_text(value)
      elsif value.is_a?(Array) || value.is_a?(Hash)
        extract_text_from_element(value)
      end
    end
  end

  def format_result(article)
    { id: article['uuid'], title: article['title'], url: article['sourceUrl'] }
  end

  def format_search_results(matching_results)
    { query: @query, articles: matching_results }
  end

  def no_articles_found
    translate('no_article_found', topic: @query.capitalize)
  end

  def translate(key, interpolations = {})
    @user.language_code ||= 'en'
    TranslationService.translate(key, @user.language_code, interpolations)
  end
end
