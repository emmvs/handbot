# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe WebhooksController, type: :request do
  describe 'POST #receive' do
    let(:chat_id) { '1234' }
    let(:first_name) { 'TestUser' }
    let(:base_params) do
      { message: { chat: { id: chat_id }, from: { first_name: first_name } } }
    end

    before do
      allow(RestClient).to receive(:post).and_return({ success: true }.to_json)
    end

    shared_examples 'processes telegram commands' do |command, response_status: :ok|
      let(:params) { base_params.deep_merge(message: { text: command }) }

      it "#{response_status} when receiving a #{command} command" do
        allow_any_instance_of(TelegramCommandService).to receive(:call).and_return("#{command} command response")
        post '/receive', params:
        expect(response).to have_http_status(response_status)
      end
    end

    include_examples 'processes telegram commands', '/start'
    include_examples 'processes telegram commands', '/help'
    include_examples 'processes telegram commands', '/search', response_status: :ok
    include_examples 'processes telegram commands', '/language', response_status: :ok
    include_examples 'processes telegram commands', '/settings', response_status: :ok
    # TODO: Add more commands here

    context 'when receiving invalid data' do
      it 'returns an error' do
        post '/receive', params: {}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('No message received')
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
