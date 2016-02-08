Rails.application.routes.draw do
  root to: 'static_pages#index'

  post '/login',  to: 'sessions#login',  as: :login
  post '/logout', to: 'sessions#logout', as: :logout

  get '/calendar', to: 'calendar#index', as: :calendar
  get '/report', to: 'report#show', as: :report

  namespace :api do
    get '/meals' => 'meals#index'
    get '/bills' => 'bills#index'
    get '/residents' => 'residents#index'
    get '/units' => 'units#index'
    get '/report' => 'report#show'
  end

  resources :residents
  resources :bills, except: [:show]
  resources :units, except: [:show]
  resources :meals
  resources :communities, except: [:show]
end
