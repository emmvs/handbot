Rails.application.routes.draw do
  root 'pages#home'
  post '/webhook', to: 'webhooks#callback'
end
