Rails.application.routes.draw do
  post '/webhook', to: 'webhooks#callback'
end
