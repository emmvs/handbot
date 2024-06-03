# frozen_string_literal: true

# The User Model manages user profile settings and session details
# for interactions with the Telegram bot
class User
  # DEFAULT_LANGUAGE = 'en'
  SUPPORTED_LANGUAGES = {
    'en' => 'English',
    'de' => 'Deutsch',
    'uk' => 'Українська',
    'tr' => 'Türkçe',
    'fr' => 'Français',
    'ru' => 'Русский',
    # 'ps' => 'پښتو',
    'ar' => 'العربية',
    'fa' => 'فارسی'
  }.freeze

  attr_accessor :chat_id, :chat_type, :username, :language_code, :command_input

  def initialize(chat_id, chat_type, username, language_code, command_input)
    @chat_id = chat_id
    @chat_type = chat_type
    @username = username
    @language_code = ensure_supported_language(language_code)
    @command_input = command_input
  end

  def language_supported?(language)
    SUPPORTED_LANGUAGES.key?(language)
  end

  private

  def ensure_supported_language(language)
    if SUPPORTED_LANGUAGES.key?(language)
      language
    end
    # SUPPORTED_LANGUAGES.key?(language) ? language : DEFAULT_LANGUAGE
  end

  def chat_id_valid?
    chat_id.match?(/\A\d+\z/)
  end
end
