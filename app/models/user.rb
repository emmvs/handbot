# frozen_string_literal: true

# User Model for managing user profile settings and session details
# for interactions with the Telegram bot. This class encapsulates
# user-related data, ensuring that all user information is validated
# and conforms to the expected standards necessary for processing commands
#
# Attributes:
#   @chat_id [String] Unique identifier for the user's chat session, typically numeric
#   @chat_type [String] Type of chat, indicates whether it's a private, group, or channel chat
#   @username [String] User's Telegram username or first name if username isn't set
#   @language_code [String] ISO language code representing the user's preferred language
#   @command_input [String] The last command or message input received from the user
#
# The model includes validation methods to ensure the presence and correctness
# of critical attributes and checks for supported languages to cater to internationalization.
#
class User
  DEFAULT_LANGUAGE = 'en'
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
    SUPPORTED_LANGUAGES.key?(language) ? language : DEFAULT_LANGUAGE
  end

  def chat_id_valid?
    chat_id.match?(/\A\d+\z/)
  end
end
