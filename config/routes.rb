Rails.application.routes.draw do
  resources :customers
  resources :support_agents
  resources :tickets do
    get :mine, on: :collection
    put :assign_to_self, on: :member
    put :admin_assign, on: :member
    resources :messages
  end
  post    'sessions'     => 'sessions#create'
  delete  'sessions' => 'sessions#destroy'
end
