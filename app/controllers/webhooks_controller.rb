class WebhooksController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def callback
    unless params[:message].present?
      return render json: { error: 'Invalid data' }, status: :bad_request
    end

    chat_id = params[:message][:chat][:id]
    text = params[:message][:text]

    send_message(chat_id, "Your request was: #{text}")
    head :ok
  end

  private

  def send_message(chat_id, text)
    token = ENV['CHAT_BOT_TOKEN']
    url = "https://api.telegram.org/bot#{token}/sendMessage"
    payload = {
      chat_id: chat_id,
      text: text
    }
    begin
      RestClient.post(url, payload.to_json, {content_type: :json, accept: :json})
    rescue RestClient::BadRequest => e
      Rails.logger.error "Failed to send message: #{e.response}"
      render json: { error: 'Bad request to Telegram API' }, status: :bad_request
    end
  end
end


# Temporary storage for user states
# USER_STATES = {}

  # def callback
  #   update = params.permit! # Permit all params for simplicity
  #   if update['message'].present?
  #     user_id = update['message']['from']['id']
  #     handle_user_message(user_id, update['message'])
  #   end

  #   render json: { success: true }
  # end

  # private

  # def handle_user_message(user_id, message)
  #   case USER_STATES[user_id]
  #   when :awaiting_language
  #     # User has been prompted to choose a language, handle that logic here
  #     chosen_language = message['text']
  #     USER_STATES[user_id] = :awaiting_search
  #     send_message(user_id, "Language set to #{chosen_language}. Please enter a word to search.")
  #   when :awaiting_search
  #     # User has chosen a language and is now sending a word to search
  #     search_word = message['text']
  #     # Implement search logic here...
  #     send_message(user_id, "Searching for '#{search_word}'...")
  #   else
  #     # Welcome message and prompt for language selection
  #     USER_STATES[user_id] = :awaiting_language
  #     send_message(user_id, 'Welcome! Please choose your language.')
  #   end
  # end

  # def send_message(chat_id, text)
  #   # ... existing implementation ...
  # end
# end
