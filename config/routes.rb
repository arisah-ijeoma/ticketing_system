Rails.application.routes.draw do
  resources :customers
  resources :support_agents
  resources :tickets do
    resources :messages
  end
  post    'sessions'     => 'sessions#create'
  delete  'sessions' => 'sessions#destroy'
end
