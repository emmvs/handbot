# Handbot
Now available via Telegram! Add @HandbookGermanyBot to your chat to get started!

Welcome to the HandBot App (Ruby on Rails Telegram Bot) - This document provides all the necessary steps to get the application up and running in your development ensvironment. HandBot is designed to interact with users in a Telegram group, providing responses to user queries based on predefined commands.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites
* Ruby 3.1.2
* Rails 7.1.3
* PostgreSQL 14.10
* A Telegram bot token (obtainable through BotFather)

## Ruby Version
Ensure you have the correct Ruby version installed. You can check your Ruby version using:

`ruby -v`

## System Dependencies
Bundler for managing Ruby gems. Install Bundler with:

`gem install bundler`

PostgreSQL as the database. Ensure PostgreSQL is installed and running on your system.

## Configuration
Clone the repository to your local machine:

`git clone https://github.com/emmvs/handbot.git`

Navigate into the project directory:

`cd handbot`

Install the required gems:

`bundle install`

## Set up environment variables:
Copy the .env.example file to .env and fill in the values for your environment, including your Telegram bot token.

## Database Creation and Initialization
Create and migrate your database:

`rails db:create db:migrate`

## Running the Test Suite
Run the RSpec test suite to ensure everything is set up correctly:

`bundle exec rspec`

## How It Works
Add Bot to Your Telegram Group: Follow the instructions from BotFather to add your bot to a Telegram group. The bot cannot initiate conversations with users but can respond to messages sent to it.

Interacting with the Bot: Users can interact with the bot by sending commands or messages that the bot is programmed to respond to.

## Services
Telegram Bot: The core service that interacts with users through Telegram messages.

## Deployment Instructions
Deployment steps will vary based on your hosting provider (Heroku, AWS, etc.). Generally, you'll need to:
Set your environment variables on the hosting platform.
Deploy your application code to the hosting service.
Ensure that your database is set up and migrated on the host.

## Additional Notes
Remember to keep your Telegram bot token secure and not expose it in your codebase.
For detailed Telegram bot development documentation, visit Telegram Bot API.

## Contributing
Contributions of all sizes are welcome. Please review our contribution guidelines to get started. You can also help by reporting bugs or feature requests.

## License