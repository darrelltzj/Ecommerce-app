Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'root#index'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'profile' => 'users#edit'
  put 'profile' => 'users#update'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # get 'dashboard' => 'products#index'
  resources :users
  resources :products
  resources :orders
end
