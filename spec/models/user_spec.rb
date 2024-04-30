# frozen_string_literal: true

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new('123456789', 'private', 'testuser', 'en', '/start')
  end

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
