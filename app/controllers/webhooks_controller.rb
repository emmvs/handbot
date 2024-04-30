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
    telegram_service = TelegramCommandService.new(@user)
    response = telegram_service.call
    send_message(@user.chat_id, response)
  end

  def extract_user_info
    chat_id = extract_param(:message, :chat, :id)
    chat_type = extract_param(:message, :chat, :type)
    username = determine_username
    language_code = extract_param(:message, :from, :language_code)
    command_input = extract_param(:message, :text)

    @user = User.new(chat_id, chat_type, username, language_code, command_input)
  end

  def extract_param(*keys)
    params.dig(*keys)
  end

  def determine_username
    first_name = extract_param(:message, :from, :first_name)
    username = extract_param(:message, :from, :username)
    first_name.empty? ? username : first_name
  end

  def send_message(chat_id, text)
    token = ENV['CHAT_BOT_TOKEN']
    url = "https://api.telegram.org/bot#{token}/sendMessage"
    payload = { chat_id:, text: }
    RestClient.post(url, payload.to_json, content_type: :json, accept: :json)
  end
end
