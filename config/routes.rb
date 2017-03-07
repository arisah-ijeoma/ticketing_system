Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  resources :customers
  resources :support_agents
  resources :tickets do
    get :mine, on: :collection
    get :report, on: :collection
    put :assign_to_self, on: :member
    put :admin_assign, on: :member
    put :resolved, on: :member
    resources :messages
  end
  post    'sessions'     => 'sessions#create'
  delete  'sessions' => 'sessions#destroy'
end
