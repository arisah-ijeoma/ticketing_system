Rails.application.routes.draw do
  resources :users
  resources :tickets
  resources :messages
end
