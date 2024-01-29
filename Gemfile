source "https://rubygems.org"

ruby "3.1.2"

# Core Rails Gems
gem "rails", "~> 7.1.3"
gem "pg", "~> 1.1" # PostgreSQL database adapter
gem "puma", ">= 5.0" # Puma web server
gem "bootsnap", require: false # Caching for faster boot times

# Telegram Bot
gem 'telegram-bot-ruby'

# Optional/Commented Out Gems
# gem "jbuilder" # JSON APIs
# gem "redis", ">= 4.0.1" # Redis adapter for Action Cable
# gem "kredis" # Higher-level data types in Redis
# gem "bcrypt", "~> 3.1.7" # Secure password for Active Model
# gem "image_processing", "~> 1.2" # Active Storage image variants
# gem "rack-cors" # Handling CORS for cross-origin Ajax

# Platform-specific Gems
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ] # Timezone data for Windows

# Development and Test Environment
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem "rspec-rails", "~> 5.0"
end

group :development do
  # gem "spring" # Speed up commands on slow machines
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby] # Highlight errors
end
