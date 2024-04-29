# frozen_string_literal: true

# User Model for Telegram User & Profile Settings
class User
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

  attr_accessor :username, :language_code, :chat_id

  def initialize(username, language_code, chat_id)
    @username = username
    @language_code = language_code
    @chat_id = chat_id
  end
end
