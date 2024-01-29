class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    # Logic to handle the Telegram updates [here]

    # Responding to Telegram to acknowledge receipt
    render json: { success: true }
  end
end
