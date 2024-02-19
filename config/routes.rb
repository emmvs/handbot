Rails.application.routes.draw do
  # Homepage
  root 'pages#home'

  # Receiving messages from Telegram & User
  # post '/', to: 'webhooks#receive'
  post '/receive', to: 'webhooks#receive'
end
