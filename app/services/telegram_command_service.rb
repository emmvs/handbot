# frozen_string_literal: true

require_relative '../models/user'
require_relative 'command_handler'

# The TelegramCommandService is responsible for interpreting the command received from the user
# and generating the appropriate response
class TelegramCommandService
  def initialize(chat_id, command, user_language, username)
    @user = User.new(username, user_language, chat_id)
    @command = command
  end

  def call
    handler = CommandHandler.new(@user)
    handler.process_command(@command)
  end
end
