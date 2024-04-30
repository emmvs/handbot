# frozen_string_literal: true

RSpec.describe WebhooksController, type: :controller do
  describe '#receive' do
    it 'processes the message successfully' do
      allow(RestClient).to receive(:post).and_return(true)

      post :receive, params: { message: { chat: { id: '123' }, text: '/start' } }
      expect(response).to have_http_status(:ok)
    end
  end
end
