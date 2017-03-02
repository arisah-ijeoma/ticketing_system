Rails.application.routes.draw do
  resources :users
  resources :tickets
  resources :messages
  post    'sessions'     => 'sessions#create'
  delete  'sessions/:id' => 'sessions#destroy'
end
