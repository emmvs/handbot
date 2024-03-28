# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe TelegramCommandService do
  subject(:service) { described_class.new(chat_id, command) }

  let(:chat_id) { '1234' }

  describe '#call' do
    context 'when command is /start' do
      let(:command) { '/start' }

      it 'returns a welcome message' do
        expect(service.call).to include('Welcome to HandBot!')
      end
    end

    context 'when command is /search' do
      let(:command) { '/search' }

      it 'prompts for search' do
        expect(service.call).to include('What topic are you interested in?')
      end
    end

    context 'when command is /help' do
      let(:command) { '/help' }

      it 'provides assistance' do
        expect(service.call).to include("Here's how you can use HandBot:")
      end
    end

    context 'when command is /language' do
      let(:command) { '/language' }

      it 'offers language options' do
        expect(service.call).to include('You can change the language. Current options are:')
      end
    end

    context 'when command is /settings' do
      let(:command) { '/settings' }

      it 'presents settings options' do
        expect(service.call).to include('Here are your settings options:')
      end
    end

    context 'with an unknown command' do
      let(:command) { '/unknown' }

      it 'handles unknown command' do
        expect(service.call).to include("Sorry, I didn't understand that. Try /help for more options.")
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
