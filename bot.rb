# require 'telegram/bot'
# require 'httparty'
# require 'nokogiri'

# token = ENV['CHAT_BOT_TOKEN']

# Telegram::Bot::Client.run(token) do |bot|
#   bot.listen do |message|
#     if message.text.downcase.include?("start")
#       bot.api.send_message(
#         chat_id: message.chat.id, 
#         text: "👋 Hey there! 
#         Welcome to HandBot! 
#         We're here to help you find information about Germany through handbookgermany.de. 
#         Please select one of the following options to get started:

#         Press '/start' to begin your search 
#         Press '/help' if you don't get a proper response from the bot 

#         How can I help you?")
#     else
#       search_query = message.text
#       response = HTTParty.get("https://handbookgermany.de/en/search/content?keys=#{URI.encode(search_query)}")
#       parsed_content = Nokogiri::HTML(response.body)
#       articles = parsed_content.css('.item')[0..2]
#       if articles.empty?
#         bot.api.send_message(chat_id: message.chat.id, text: "I couldn't find any articles related to '#{search_query.downcase}'.")
#       else
#         articles_info = articles.map do |article|
#           title = article.css('h4').text.strip
#           url = article.css('a')['href']
#           "#{title}: #{url}"
#         end.join("\n")
#         bot.api.send_message(chat_id: message.chat.id, text: articles_info + "Was this what you were looking for?")
#       end
#     end
#   end
# end

# Send a message to person w/ user ID
# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=262447015&text=Hello

# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=#{user_id}&text=#{text}

# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=#{group_id}&text=#{text}

# Get Webhook Info
# https://api.telegram.org/botBOT_TOKEN/getWebhookInfo

# TODO: First message is the most important
# Should it be personal or not so personal (firstname, info, etc.)
# Inputs need to be readable, for example, typos, different languages, etc.
# => Ai and/or Elastic Search

# Choose your language (9 languages)
# Deutsch (German) Englishاَلْعَرَبِيَّة (Arabic)فارسی/دری (Persian)
# Türkçe (Turkish) Français (French)پښتو (Pashto) Pусский (Russian) Українська (Ukrainian)
# Im sorry, I did not find the article in your language, maybe this will be helpful: [article in Eng/Ger/etc.]

# API w/ full database of articles of handbook Germany

# Need more help? Share your phone number, etc.
# HandBook Germany wants to collect what data?

# Notes
# Super popular bot by the government
# http://t.me/Diia_help_bot

# ? When restarting ngrok, we also need to reset the webhook
# TODO: Update YOUR_BOT_TOKEN="your_bot_token_here"
# TODO: Update ngrok link w/ new ngrok url

# YOUR_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"

# curl -X POST \
#      -H "Content-Type: application/json" \
#      -d '{"url": "https://f708-84-130-234-178.ngrok-free.app/receive"}' \
#      "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/setWebhook"

# When you restart ngrok, it generates a new random URL for your tunnel.
# Since the Telegram bot's webhook URL is configured to use the ngrok URL,
# you'll need to update the webhook URL with the new ngrok URL every time you restart ngrok
# This needs to happen until the app gets deloyed and we have the same URL

# You should get the output below 👇🏻
# {"ok":true,"result":true,"description":"Webhook was set"}
