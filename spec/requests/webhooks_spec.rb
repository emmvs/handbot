require 'rails_helper'

RSpec.describe WebhooksController, type: :request do
    describe 'POST /callback' do
        context 'with valid data from Telegram' do
        let(:valid_params) do
            {
            update_id: 1,
            message: {
                message_id: 1,
                from: {
                id: 123,
                is_bot: false,
                first_name: "Test",
                username: "testuser"
                },
                chat: {
                id: 123,
                first_name: "Test",
                username: "testuser",
                type: "private"
                },
                date: 1_614_451_073,
                text: "Hello from Telegram"
            }
            }
        end

        it 'processes the message and responds successfully' do
            post '/webhook', params: valid_params

            expect(response).to have_http_status(:success)
        end
        end

        context 'with invalid data' do
        let(:invalid_params) { {} }

        it 'handles the error appropriately' do
            post '/webhook', params: invalid_params

            expect(response).to have_http_status(:bad_request)
        end
        end
    end
end