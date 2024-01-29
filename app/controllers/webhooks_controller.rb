class WebhooksController < ApplicationController

  # def callback
  #   # Logic to handle the Telegram updates [here]

  #   # Responding to Telegram to acknowledge receipt
  #   render json: { success: true }
  # end

  def callback
    token = Rails.application.credentials.telegram_bot[:token]
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
        end
      end
    end
    head :ok
  end
end
