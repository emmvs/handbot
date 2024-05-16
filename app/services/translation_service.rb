# frozen_string_literal: true

# Handles translations for various components
class TranslationService < ApplicationService
  LOCALES_DIR = File.join(Dir.pwd, 'config', 'locales')

  def self.translate(key, user_language, interpolations = {})
    translations = load_translations(user_language)
    message = translations.dig(user_language, *key.split('.'))

    if message
      format_message(message, interpolations)
    else
      puts "❌ Translation missing: #{key} for language: #{user_language}"
    end
  end

  # Helper method to format the message with interpolations
  def self.format_message(message, interpolations)
    # Check each key in the message format to ensure it's provided in interpolations
    missing_keys = message.scan(/%\{([^}]+)\}/).flatten - interpolations.keys.map(&:to_s)
    if missing_keys.empty?
      # Interpolate topics, names, etc. in messages
      message % interpolations
    else
      puts "❌ Missing interpolation keys: #{missing_keys.join(', ')}"
    end
  end

  # Loads translations from a YAML file specific to the provided language
  def self.load_translations(lang)
    file_path = File.join(LOCALES_DIR, "#{lang}.yml")
    YAML.load_file(file_path)
  end
end

#   def translate(yaml_key, attributes = {})
#     message_template = fetch_translation(yaml_key)
#     message_template ||= fetch_fallback_translation(yaml_key) || missing_translation(yaml_key)
#     message_template ? format(message_template, attributes) : missing_translation(yaml_key)
#   end

#   def supported_languages_list
#     SUPPORTED_LANGUAGES.map do |code, _|
#       translated_name = translate("languages.#{code}")
#       "#{translated_name} (/#{code})"
#     end.join(', ')
#   end

#   def fetch_translation(yaml_key)
#     translations = load_translations(@user_language)
#     translations.dig(@user_language, *yaml_key.split('.'))
#   end

#   def fetch_fallback_translation(yaml_key)
#     return if @user_language == 'en'

#     english_translations = load_translations('en')
#     english_translations.dig(@user_language, *yaml_key.split('.'))
#   end

#   def load_translations(lang)
#     file_path = target_file(lang)
#     YAML.load_file(file_path)
#   end

#   def missing_translation(yaml_key)
#     "Translation missing for '#{yaml_key}'. 😭"
#   end

#   def target_file(lang_code)
#     File.join(LOCALES_DIR, "#{lang_code}.yml")
#   end
# end
