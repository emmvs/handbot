# frozen_string_literal: true

require 'rest-client'
require_relative '../services/article_search_service'
require_relative '../services/article_scrape_service'
require_relative '../services/telegram_command_service'

# The WebhooksController handles incoming webhook requests from Telegram API
# responding to messages sent to the Telegram bot associated with this application.
# It includes methods for validating and processing incoming messages (`callback`),
# acknowledging webhook setup (`receive`), and sending messages back to the user
# via the TelegramCommandService
class WebhooksController < ApplicationController
  # Uncomment if you need to skip CSRF token verification
  # skip_before_action :verify_authenticity_token

  def receive
    if valid_message_received?
      process_user_message
      render json: { message: 'Message processed successfully' }, status: :ok
    else
      render json: { error: 'Invalid request' }, status: :bad_request
    end
  end

  private

  def valid_message_received?
    params[:message].present?
  end

  def process_user_message
    extract_user_info
    telegram_service = TelegramCommandService.new(@chat_id, @command_input, @language_code, @username)
    response = telegram_service.call

    send_message(@chat_id, response)
  end

  def extract_user_info
    @chat_id = params[:message][:chat][:id]
    @command_input = params[:message][:text]
    @language_code = params[:message][:from][:language_code]
    @username = params[:message][:from][:first_name]
  end

  def send_message(chat_id, text)
    token = ENV['CHAT_BOT_TOKEN']
    url = "https://api.telegram.org/bot#{token}/sendMessage"
    payload = { chat_id:, text: }
    RestClient.post(url, payload.to_json, content_type: :json, accept: :json)
  end
end
