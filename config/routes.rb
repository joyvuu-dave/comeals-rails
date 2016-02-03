Rails.application.routes.draw do
  root to: 'static_pages#index'

  resources :residents
  resources :bills
  resources :units
  resources :meals
  resources :communities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
