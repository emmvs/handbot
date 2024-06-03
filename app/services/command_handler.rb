# frozen_string_literal: true


require_relative '../../lib/command_definitions'

# The CommandHandler handles all commands sent to the Telegram bot
# (/start, /help, /search, /settings, /language) in a single, reusable component
# Each public method within the service corresponds to a specific command,
# simplifying the command processing workflow within the bot's controllers or other services
class CommandHandler < ApplicationService
  include CommandDefinitions

  HANDBOOK_BASE_URI = ENV['HANDBOOK_BASE_URI']

  attr_reader :user, :args, :user_language

  def initialize(user)
    super()
    @user = user
  end

  def call(command)
    return process_command(command) if command.start_with?('/')

    perform_search(command) # Any non-command text is a search query
  end

  private

  def process_command(command) # rubocop:disable Metrics/MethodLength
    case command
    when command_for(:start)
      send_initial_greeting
    when command_for(:help)
      translate('help_response')
    when command_for(:search)
      translate('search_prompt')
    when command_for(:settings)
      translate('settings_response')
    when command_for(:languages)
      translate('change_language', languages: formatted_languages)
    else
      translate('unknown_command_response')
    end
  end

  def command_for(action)
    CommandDefinitions::COMMAND_SETS.fetch(@user.language_code, CommandDefinitions::COMMAND_SETS['en'])[action]
  end

  def perform_search(query)
    search_service = SearchService.new(query, @user)
    results = search_service.search
    format_search_results(results, query)
  end

  def send_initial_greeting
    translation_key = 'initial_greeting'
    interpolations = { username: @user.username, language_options: formatted_languages }
    translate(translation_key, interpolations)
  end

  def format_search_results(results, query)
    return translate('no_article_found', topic: query.capitalize) unless results.is_a?(Hash) && results[:articles]

    keyword = query
    articles = results[:articles]

    articles_header = translate('articles_found', topic: keyword.capitalize)
    articles_list = articles.map do |article|
      "• #{article[:title]}: #{HANDBOOK_BASE_URI}#{article[:url]}"
    end.join("\n")

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

  def formatted_languages
    User::SUPPORTED_LANGUAGES.map { |code, language| "• #{language} (#{code})\n" }.join('')
  end
end
