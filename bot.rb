require 'telegram/bot'
require 'httparty'
require 'nokogiri'

token = ENV['CHAT_BOT_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    if message.text.downcase.include?("start")
      bot.api.send_message(
        chat_id: message.chat.id, 
        text: "👋 Hey there! 
        Welcome to HandBot! 
        We're here to help you find information about Germany through handbookgermany.de. 
        Please select one of the following options to get started:

        Press '/start' to begin your search 
        Press '/help' if you don't get a proper response from the bot 

        How can I help you?")
    else
      search_query = message.text
      response = HTTParty.get("https://handbookgermany.de/en/search/content?keys=#{URI.encode(search_query)}")
      parsed_content = Nokogiri::HTML(response.body)
      articles = parsed_content.css('.item')[0..2]
      if articles.empty?
        bot.api.send_message(chat_id: message.chat.id, text: "I couldn't find any articles related to '#{search_query.downcase}'.")
      else
        articles_info = articles.map do |article|
          title = article.css('h4').text.strip
          url = article.css('a')['href']
          "#{title}: #{url}"
        end.join("\n")
        bot.api.send_message(chat_id: message.chat.id, text: articles_info + "Was this what you were looking for?")
      end
    end
  end
end

# Send a message to person w/ user ID
# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=262447015&text=Hello

# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=#{user_id}&text=#{text}

# https://api.telegram.org/botBOT_TOKEN/sendMessage?chat_id=#{group_id}&text=#{text}

# Get Webhook Info
# https://api.telegram.org/botBOT_TOKEN/getWebhookInfo
