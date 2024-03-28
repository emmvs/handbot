# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

FactoryBot.define do
  factory :telegram_message, class: Hash do
    skip_create

    transient do
      chat_type { 'private' }
    end

    trait :group_message do
      chat_type { 'group' }
    end

    trait :private_message do
      chat_type { 'private' }
    end

    initialize_with do
      {
        update_id: Faker::Number.number(digits: 10),
        message: {
          message_id: Faker::Number.number(digits: 10),
          from: {
            id: Faker::Number.number(digits: 10),
            is_bot: false,
            first_name: Faker::Name.first_name,
            username: Faker::Internet.username,
            language_code: 'en'
          },
          chat: {
            id: Faker::Number.number(digits: 10),
            type: chat_type,
            title: chat_type == 'group' ? Faker::Team.name : nil,
            all_members_are_administrators: chat_type == 'group'
          },
          date: Faker::Time.between(from: 2.days.ago, to: Time.now).to_i,
          text: '/start',
          entities: [{ offset: 0, length: 6, type: 'bot_command' }]
        }
      }
    end
  end
end

# rubocop:enable Metrics/BlockLength
