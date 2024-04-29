# frozen_string_literal: true

require 'yaml'

# Handles translations for various components
class TranslationService
  LOCALES_DIR = File.join(Dir.pwd, 'config', 'locales')

  def self.translate(key, user_language, interpolations = {})
    translations = load_translations(user_language)
    message = translations.dig(user_language, *key.split('.'))

    if message
      format_message(message, interpolations)
    else
      puts "👻👻👻 Translation missing: #{key} for language: #{user_language}"
    end
  end

  # Helper method to format the message with interpolations
  def self.format_message(message, interpolations)
    # Check each key in the message format to ensure it's provided in interpolations
    missing_keys = message.scan(/%\{([^}]+)\}/).flatten - interpolations.keys.map(&:to_s)
    if missing_keys.empty?
      message % interpolations
    else
      puts "👻👻👻 Missing interpolation keys: #{missing_keys.join(', ')}"
    end
  end

  # Loads translations from a YAML file specific to the provided language
  def self.load_translations(lang)
    file_path = File.join(LOCALES_DIR, "#{lang}.yml")
    YAML.load_file(file_path)
  end
end
