# frozen_string_literal: true

require_relative '../models/user'
require_relative 'command_handler'

# The TelegramCommandService is responsible for interpreting the command received from the user
# and generating the appropriate response from Telegram Bot
class TelegramCommandService < ApplicationService
  def initialize(user)
    super()
    @user = user
    @command = user.command_input
  end

  def call
    handler = CommandHandler.new(@user)
    handler.call(@command)
  end
end
