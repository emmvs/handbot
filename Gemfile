# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.2'

# Core Rails Gems
gem 'pg', '~> 1.1' # PostgreSQL database adapter
gem 'puma', '>= 5.0' # Puma web server
gem 'rails', '~> 7.1.3'

# Front End
gem 'bootstrap', '~> 5.2'
gem 'sassc-rails'

# Telegram Bot & APIs
gem 'httparty'
gem 'jbuilder' # JSON APIs
gem 'rest-client'
gem 'telegram-bot-ruby'

# Optional/Commented Out Gems
# gem 'redis', '>= 4.0.1' # Redis adapter for Action Cable
# gem 'kredis' # Higher-level data types in Redis
# gem 'bcrypt', '~> 3.1.7' # Secure password for Active Model
# gem 'image_processing', '~> 1.2' # Active Storage image variants
# gem 'rack-cors' # Handling CORS for cross-origin Ajax

# Performance & Optimization
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ] # Timezone data for Windows

# Development and Test Environment
group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 6.0.2'
end

group :development do
  # gem 'spring' # Speed up commands on slow machines
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby] # Highlight errors
  gem 'rubocop', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 6.0'
end
