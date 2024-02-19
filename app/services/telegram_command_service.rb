# The TelegramCommandService is responsible for interpreting the command received from the user
# and generating the appropriate response
# This service aims to encapsulate the logic for handling different commands
# (/start, /help, /search, /settings, /language) in a single, reusable component
# Each public method within the service corresponds to a specific command,
# simplifying the command processing workflow within the bot's controllers or other services
class TelegramCommandService
  attr_reader :chat_id, :command

  def initialize(chat_id, command)
    @chat_id = chat_id
    @command = command.downcase
  end

  def call(*args)
    action = command_method
    # Checks number of expected arguments
    method(action).arity.zero? ? send(action) : send(action, *args)
  end

  private

  def command_method
    case command
    when '/start' then :send_initial_greeting
    when '/search' then :prompt_for_search
    when '/help' then :send_help_response
    when '/language' then :send_language_options
    when '/settings' then :send_settings_response
    else :handle_unknown_command
    end
  end

  def send_initial_greeting(username = nil)
    greeting = '👋 Hey there'
    greeting += ", #{username}" if username
    greeting + "! Welcome to HandBot!

    We're here to help you find information about Germany through handbookgermany.de. Please select one of the following options to get started:

    Press '/search' to begin your search
    Press '/language' to change your language
    Press '/settings' to change your settings
    Press '/help' if you don't get a proper response from the bot

    How can I help you?"
  end

  def send_help_response
    # Logic for sending help response
    "Here's how you can use HandBot: ..."
  end

  def prompt_for_search
    # Logic to prompt user for search
    "What topic are you interested in? Just type and I'll look it up for you!"
  end

  def send_settings_response
    # Logic for sending settings options
    'Here are your settings options: ...'
  end

  def send_language_options
    # Logic for sending language options
    'You can change the language. Current options are: ...'
  end

  def send_default_response
    # Fallback message for unrecognized commands
    "Sorry, I didn't understand that. Try /help for more options."
  end

  def handle_unknown_command
    "Sorry, I didn't understand that. Try /help for more options."
  end
end
