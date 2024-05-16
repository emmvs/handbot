# frozen_string_literal: true

# The TelegramClient manages HTTP requests to the Telegram API.
#
# This client is responsible for sending messages and answering inline queries
# via the Telegram bot API. It abstracts the HTTP requests and makes it easier
# to send and manage interactions with Telegram.
#
# Example usage:
#   TelegramClient.send_message(chat_id, "Hello, World!")
#   TelegramClient.answer_inline_query(inline_query_id, formatted_results)
#
class TelegramClient
  BASE_URL = "https://api.telegram.org/bot#{ENV['CHAT_BOT_TOKEN']}".freeze

  def self.send_message(chat_id, text)
    url = "#{BASE_URL}/sendMessage"
    HTTParty.post(url, body: { chat_id:, text: }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.answer_inline_query(inline_query_id, results)
    url = "#{BASE_URL}/answerInlineQuery"
    HTTParty.post(url, body: { inline_query_id:, results: results.to_json }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
