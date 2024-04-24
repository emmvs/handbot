# frozen_string_literal: true

require 'yaml'

# The TelegramCommandService is responsible for interpreting the command received from the user
# and generating the appropriate response
# This service aims to encapsulate the logic for handling different commands
# (/start, /help, /search, /settings, /language) in a single, reusable component
# Each public method within the service corresponds to a specific command,
# simplifying the command processing workflow within the bot's controllers or other services
class TelegramCommandService
  LOCALES_DIR = File.join(Dir.pwd, 'config', 'locales')

  SUPPORTED_LANGUAGES = {
    'en' => 'English',
    'de' => 'German',
    'uk' => 'Ukrainian',
    'ar' => 'Arabic',
    'fa' => 'Persian',
    'tr' => 'Turkish',
    'fr' => 'French',
    'ps' => 'Pashto',
    'ru' => 'Russian'
  }.freeze

  attr_reader :chat_id, :command, :user_language

  def initialize(chat_id, command, user_language, username)
    @chat_id = chat_id
    @command = command
    @user_language = user_language
    @username = username
  end

  def call(*args)
    action = command_method
    # Calls #action w/o arguments if it expects none, otherwise passes arguments
    method(action).arity.zero? ? send(action) : send(action, *args)
  end

  private

  def command_method
    case command
    when '/start' then :send_initial_greeting
    when '/search' then :prompt_for_search
    when '/help' then :send_help_response
    when '/language' then :send_language_options
    when '/settings' then :send_settings_response
    else :handle_unknown_command
    end
  end

  def send_initial_greeting
    translate('telegram_commands.initial_greeting', username: @username)
  end

  def send_help_response
    translate('telegram_commands.help_response')
  end

  def prompt_for_search
    translate('telegram_commands.prompt_for_search')
  end

  def send_settings_response
    translate('telegram_commands.settings_response')
  end

  def send_language_options
    supported_languages_list
  end

  def change_to_en
    # TODO: Change @user_language w/ new language_code
    # translate('language_change_confirmation')
  end

  def change_to_de
    # TODO: Change @user_language w/ new language_code
    # translate('language_change_confirmation')
  end

  def change_to_uk
    # TODO: Change @user_language w/ new language_code
    # translate('language_change_confirmation')
  end

  def send_default_response
    translate('telegram_commands.default_response')
  end

  def handle_unknown_command
    translate('telegram_commands.unknown_command_response')
  end

  def supported_languages_list
    SUPPORTED_LANGUAGES.map do |code, _|
      translated_name = translate("languages.#{code}")
      "#{translated_name} (/#{code})"
    end.join(', ')
  end

  def translate(yaml_key, attributes = {})
    message_template = fetch_translation(yaml_key)
    message_template ||= fetch_fallback_translation(yaml_key) || missing_translation(yaml_key)
    message_template ? format(message_template, attributes) : missing_translation(yaml_key)
  end

  def fetch_translation(yaml_key)
    translations = load_translations(@user_language)
    translations.dig(@user_language, *yaml_key.split('.'))
  end

  def fetch_fallback_translation(yaml_key)
    return if @user_language == 'en'

    english_translations = load_translations('en')
    english_translations.dig(@user_language, *yaml_key.split('.'))
  end

  def load_translations(lang)
    file_path = target_file(lang)
    YAML.load_file(file_path)
  end

  def missing_translation(yaml_key)
    "Translation missing for '#{yaml_key}'. 😭"
  end

  def target_file(lang_code)
    File.join(LOCALES_DIR, "#{lang_code}.yml")
  end
end
