# frozen_string_literal: true

# OVERVIEW
# How the Rails app works with the Telegram API
# & what is triggered at every step

# Initialization
# The app initializes the Telegram bot using a token obtained from environment variables (ENV['CHAT_BOT_TOKEN'])

# Webhook Management
# The app sets a webhook to receive messages from Telegram
# Each time ngrok/the web server is restarted, a new URL is generated, necessitating an update to the webhook URL

# Replace YOUR_BOT_TOKEN with your bot's token and NEW_NGROK_URL with the current ngrok URL.
# You can do this directly within your terminal (bash)

# YOUR_BOT_TOKEN="12345678_YOUR_TOKEN_HERE"
# NEW_NGROK_URL="https://2d0d-185-104-138-53.ngrok-free.app"

# curl -X POST -H "Content-Type: application/json" -d "{\"url\": \"${NEW_NGROK_URL}/receive\"}" "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/setWebhook"

# You should get the output below 👇🏻
# {"ok":true,"result":true,"description":"Webhook was set"}

# Please check your variables again if you get the following:
# {"ok":true,"result":true,"description":"Webhook is already deleted"}

# Get Webhook Info
# curl "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/getWebhookInfo"

# Commands List
# /start - Start the bot and provides an introduction
# /help - Get help information
# /search - Initiates a search for information
# /settings - Allows changing bot settings
# /languages - Allows changing the language

# Notes
# - Personalization:
#   The bot can be personalized to greet users by their first name and provide language-specific responses
# - Error Handling:
#   Ensures users are informed when no relevant search results are found
# - Webhook Management:
#   Needs regular updating with the new ngrok URL until deployment with a fixed URL

# Send a message to person w/ user ID
# https://api.telegram.org/bot${YOUR_BOT_TOKEN}/sendMessage?chat_id=262447015&text=Hello

# https://api.telegram.org/bot${YOUR_BOT_TOKEN}/sendMessage?chat_id=#{user_id}&text=#{text}

# https://api.telegram.org/bot${YOUR_BOT_TOKEN}/sendMessage?chat_id=#{group_id}&text=#{text}

# ADDITIONALLY
# => Ai and/or Elastic Search
# => What about typos?
# => Enable 9 HandbookGermany Languages available on website
# => Im sorry, I did not find the article in your language, maybe this will be helpful: [article in Eng/Ger/etc.]

# Send /languages to Telegram

# start - Start the bot
# help - Get help
# search - Search for information
# settings - Change settings
# languages - Change language
# los_gehts - Starte den Bot
# hilfe - Hilfe erhalten
# suche - Suche nach Informationen
# einstellungen - Einstellungen ändern
# sprachen - Sprache ändern
# почати - Запустити бота
# допомога - Отримати допомогу
# пошук - Пошук інформації
# налаштування - Змінити налаштування
# мови - Змінити мову
# başlat - Botu başlat
# yardım - Yardım al
# ara - Bilgi ara
# ayarlar - Ayarları değiştir
# diller - Dili değiştir
# commencer - Démarrer le bot
# aide - Obtenir de l'aide
# recherche - Rechercher des informations
# paramètres - Modifier les paramètres
# langues - Changer de langue
# начать - Запустить бота
# помощь - Получить помощь
# поиск - Поиск информации
# настройки - Изменить настройки
# языки - Изменить язык

# ابدأ - بدء الروبوت
# مساعدة - الحصول على المساعدة
# بحث - البحث عن المعلومات
# إعدادات - تغيير الإعدادات
# لغات - تغيير اللغة

# شروع - راه‌اندازی ربات
# کمک - دریافت کمک
# جستجو - جستجوی اطلاعات
# تنظیمات - تغییر تنظیمات
# زبان‌ها - تغییر زبان
