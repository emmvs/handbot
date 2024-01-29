require 'rails_helper'

RSpec.describe WebhooksController, type: :request do
  describe 'POST /callback' do
    context 'with valid data from Telegram' do
      let(:valid_params) { { message: { text: 'Hello from Telegram' } } }

      it 'processes the message and responds successfully' do
        post '/callback', params: valid_params

        expect(response).to have_http_status(:success)
        # Additional assertions as necessary
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { } }

      it 'handles the error appropriately' do
        post '/callback', params: invalid_params

        # Update this to match the actual response of your controller
        expect(response).to have_http_status(:unprocessable_entity)
        # or :bad_request, depending on how your controller handles it
      end
    end
  end
end
