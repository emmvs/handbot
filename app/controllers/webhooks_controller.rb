# frozen_string_literal: true

# The WebhooksController handles incoming webhook requests from Telegram API
# responding to messages sent to the Telegram bot associated with this application.
# It includes methods for validating and processing incoming messages (`callback`),
# acknowledging webhook setup (`receive`), and sending messages back to the user
class WebhooksController < ApplicationController
  # Uncomment if you need to skip CSRF token verification
  # skip_before_action :verify_authenticity_token

  def receive
    if valid_message_received?
      process_user_message
      render json: { message: 'Message processed successfully' }, status: :ok unless performed?
    else
      render_no_message_error unless performed?
    end
  end

  def process_user_message
    chat_id = extract_chat_id
    username = extract_username
    text = params[:message][:text]

    if command?(text)
      response = TelegramCommandService.new(chat_id, text).call(username)
      send_message(chat_id, response)
    else
      search_keyword_and_respond(chat_id, username, text)
    end
  end

  private

  def valid_message_received?
    params[:message].present?
  end

  def extract_chat_id
    params[:message][:chat][:id]
  end

  def command?(text)
    text.start_with?('/')
  end

  def extract_username
    params[:message][:from][:first_name]
  end

  # def extract_keyword(query)
  #   query.downcase.include?('anmeldung') ? 'anmeldung' : nil
  #   # TODO: Extend w/ GPT
  # end

  def search_keyword_and_respond(chat_id, first_name, keyword)
    return send_unrecognized_query_response(chat_id, first_name) unless keyword == 'anmeldung'

    link = search_for_keyword(keyword)
    message = build_response_message(first_name, keyword, link)
    send_message(chat_id, message)
  end

  def build_response_message(first_name, keyword, link)
    if link
      "Here's something I found about #{keyword}: #{link}"
    else
      "Sorry, #{first_name}, I couldn't find any information about #{keyword}."
    end
  end

  def send_unrecognized_query_response(chat_id, first_name)
    response_text = "Hi #{first_name}, I'm not sure how to help with that. Can you try asking about something else?"
    send_message(chat_id, response_text)
  end

  def search_for_keyword(keyword)
    # TODO: Adjust w/ API
    "https://handbookgermany.de/en/search/content?keys=#{keyword}"
  end

  def send_message(chat_id, text, disable_web_page_preview = false)
    token = ENV['CHAT_BOT_TOKEN']
    url = "https://api.telegram.org/bot#{token}/sendMessage"
    payload = { chat_id:, text:, disable_web_page_preview: }
    post_message(url, payload)
  end

  def post_message(url, payload)
    RestClient.post(url, payload.to_json, { content_type: :json, accept: :json })
  rescue RestClient::BadRequest => e
    handle_send_message_error(e.response)
  end

  def handle_send_message_error(response)
    Rails.logger.error "Failed to send message: #{response}"
    render json: { error: 'Bad request to Telegram API' }, status: :unprocessable_entity
  end

  def render_no_message_error
    render json: { error: 'No message received' }, status: :unprocessable_entity
  end
end
