Rails.application.routes.draw do
  resources :customers
  resources :support_agents
  resources :tickets
  resources :messages
  post    'sessions'     => 'sessions#create'
  delete  'sessions' => 'sessions#destroy'
end
