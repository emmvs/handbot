# frozen_string_literal: true

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  let(:valid_user) { User.new('123456789', 'private', 'testuser', 'en', '/start') }
  let(:user_with_nils) { User.new(nil, nil, nil, nil, nil) }
  let(:user_with_invalid_chat_id) { User.new('abc123', 'private', 'testuser', 'en', '/start') }
  let(:user_with_unsupported_language) { User.new('123456789', 'private', 'testuser', 'xx', '/start') }

  describe 'Initialization' do
    it 'initializes with correct attributes for a valid user' do
      expect(valid_user.chat_id).to eq('123456789')
      expect(valid_user.chat_type).to eq('private')
      expect(valid_user.username).to eq('testuser')
      expect(valid_user.language_code).to eq('en')
      expect(valid_user.command_input).to eq('/start')
    end

    it 'handles nil values gracefully' do
      expect(user_with_nils.chat_id).to be_nil
      expect(user_with_nils.chat_type).to be_nil
      expect(user_with_nils.username).to be_nil
      expect(user_with_nils.command_input).to be_nil
    end

    it 'sets default language when unsupported language is provided' do
      expect(user_with_unsupported_language.language_code).to eq(User::DEFAULT_LANGUAGE)
    end

    it 'retains the language when supported language provided' do
      expect(valid_user.language_code).to eq('en')
    end
  end

  describe 'Validations' do
    it 'checks chat_id format' do
      expect(valid_user.send(:chat_id_valid?)).to be true
      expect(user_with_invalid_chat_id.send(:chat_id_valid?)).to be false
    end

    it 'checks if the language is supported' do
      expect(valid_user.language_supported?(valid_user.language_code)).to be true
      expect(valid_user.language_supported?('xx')).to be false
    end
  end
end
