Rails.application.routes.draw do
  root to: 'static_pages#index'

  post '/login',  to: 'sessions#login',  as: :login
  post '/logout', to: 'sessions#logout', as: :logout

  get '/calendar', to: 'calendar#index', as: :calendar

  namespace :api do
    get '/meals' => 'meals#index'
    get '/bills' => 'bills#index'
  end

  resources :residents
  resources :bills
  resources :units
  resources :meals
  resources :communities
end
