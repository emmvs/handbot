# frozen_string_literal: true

require_relative '../services/article_search_service'
require_relative '../services/article_scrape_service'
require_relative '../services/translation_service'

# The CommandHandler handles all commands sent to the Telegram bot
# (/start, /help, /search, /settings, /language) in a single, reusable component
# Each public method within the service corresponds to a specific command,
# simplifying the command processing workflow within the bot's controllers or other services
class CommandHandler
  attr_reader :user, :args, :user_language

  def initialize(user)
    @user = user
  end

  def process_command(command)
    command_handler = {
      '/start' => -> { handle_start },
      '/search' => -> { handle_search },
      '/help' => -> { handle_help },
      '/settings' => -> { handle_settings },
      '/language' => -> { handle_language }
    }

    handler = command_handler[command] || command_handler["/search_#{command}"] || method(:handle_unknown_command)
    handler.call
  end

  private

  def handle_start
    send_initial_greeting
  end

  def send_initial_greeting
    translation_key = 'initial_greeting'
    interpolations = { username: @user.username }
    translate(translation_key, interpolations)
  end

  def handle_search
    translate('search_prompt')
  end

  def handle_search_with_keyword(command)
    keyword = extract_keyword(command)
    perform_search(keyword)
  end

  def extract_keyword(command)
    command.split('_', 2).last
  end

  def perform_search(keyword)
    results = search_articles(keyword)
    results.empty? ? translate('no_article_found', topic: keyword.capitalize) : format_results(results, keyword)
  end

  def search_articles(keyword)
    ArticleSearchService.search_by_keyword(keyword).presence || ArticleScrapeService.scrape_articles(keyword)
  end

  def handle_help
    translate('help_response')
  end

  def handle_settings
    translate('settings_response')
  end

  def handle_language
    translate('language_options', languages: supported_languages_list)
  end

  def handle_unknown_command
    translate('unknown_command_response')
  end

  def format_results(articles, keyword)
    articles_header = translate('articles_found', topic: keyword.capitalize)
    articles_list = articles.map { |article| "#{article[:title]}: #{article[:link]}" }.join("\n")
    "#{articles_header}\n#{articles_list}"
  end

  def translate(key, interpolations = {})
    TranslationService.translate(key, @user.language_code, interpolations)
  end

  def supported_languages_list
    User::SUPPORTED_LANGUAGES.map do |code, name|
      "#{name} (/#{code})"
    end.join(', ')
  end
end
