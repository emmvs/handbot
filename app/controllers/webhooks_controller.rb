# frozen_string_literal: true

# The WebhooksController handles incoming webhook requests from Telegram API
# responding to messages sent to the Telegram bot associated with this application.
# It includes methods for validating and processing incoming messages (`callback`),
# acknowledging webhook setup (`receive`), and sending messages back to the user
# via the TelegramCommandService
class WebhooksController < ApplicationController
  # Uncomment if you need to skip CSRF token verification
  # skip_before_action :verify_authenticity_token

  def receive
    if message_request?
      p "🟢 /message #{params[:message]}"
      handle_message(params[:message])
    elsif inline_query_request?
      p "🟡 [inline query] #{params[:inline_query]}"
      handle_inline_query(params[:inline_query])
    else
      render_invalid_request
    end
  end

  private

  def message_request?
    params[:message].present?
  end

  def inline_query_request?
    params[:inline_query].present?
  end

  def render_invalid_request
    render json: { error: 'Invalid request' }, status: :bad_request
  end

  def handle_message(message)
    user = extract_user_info(message)
    response = TelegramCommandService.new(user).call
    send_message(user.chat_id, response) unless response.nil?
  end

  def handle_inline_query(inline_query)
    user = extract_user_info(inline_query)
    results = SearchService.new(inline_query[:query], user).search
    answer_inline_query(inline_query[:id], results)
  end

  def extract_user_info(data)
    chat_id = data.dig(:chat, :id)
    name = data.dig(:from, :first_name) || data.dig(:from, :username)
    chat_type = data.dig(:chat, :type)
    language_code = data.dig(:from, :language_code)
    command_input = data[:text]

    User.new(chat_id, chat_type, name, language_code, command_input)
  end

  def send_message(chat_id, text)
    url = "https://api.telegram.org/bot#{ENV['CHAT_BOT_TOKEN']}/sendMessage"
    HTTParty.post(url, body: { chat_id:, text: }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def answer_inline_query(inline_query_id, results)
    formatted_results = results.map do |result|
      { type: 'article', id: result[:id], title: result[:title], input_message_content: { message_text: result[:url] } }
    end

    url = "https://api.telegram.org/bot#{ENV['CHAT_BOT_TOKEN']}/answerInlineQuery"
    HTTParty.post(url, body: { inline_query_id:, results: formatted_results.to_json }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
