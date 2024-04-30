# frozen_string_literal: true

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  before(:each) do
    @user = User.new('123456789', 'private', 'testuser', 'en', '/start')
  end

  context 'when initialized with valid attributes' do
    it 'initializes with correct attributes' do
      expect(@user.chat_id).to eq('123456789')
      expect(@user.chat_type).to eq('private')
      expect(@user.username).to eq('testuser')
      expect(@user.language_code).to eq('en')
      expect(@user.command_input).to eq('/start')
    end

    it 'supports supported languages' do
      expect(User::SUPPORTED_LANGUAGES.keys).to include(@user.language_code)
    end
  end

  context 'when initialized with nil attributes' do
    let(:user_with_nils) { User.new(nil, nil, nil, nil, nil) }

    it 'handles nil values gracefully' do
      expect(user_with_nils.chat_id).to be_nil
      expect(user_with_nils.chat_type).to be_nil
      expect(user_with_nils.username).to be_nil
      expect(user_with_nils.command_input).to be_nil
    end
  end

  context 'when an unsupported language is provided' do
    let(:user_with_unsupported_language) { User.new('123456789', 'private', 'testuser', 'xx', '/start') }

    it 'falls back to the default language (en)' do
      expect(user_with_unsupported_language.language_code).to eq(User::DEFAULT_LANGUAGE)
    end
  end

  context 'when a supported language is provided' do
    let(:user_with_supported_language) { User.new('123456789', 'private', 'testuser', 'en', '/start') }

    it 'keeps the specified language' do
      expect(user_with_supported_language.language_code).to eq('en')
    end
  end
end
