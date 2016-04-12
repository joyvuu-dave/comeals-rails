Rails.application.routes.draw do
  root to: 'static_pages#index'

  post '/login',  to: 'sessions#login',  as: :login
  post '/logout', to: 'sessions#logout', as: :logout

  get '/calendar', to: 'calendar#index', as: :calendar
  get '/report',   to: 'report#show',    as: :report
  get '/admin',    to: 'admin#show',     as: :admin

  namespace :api do
    get '/meals'       => 'meals#index'
    get '/meals/:id'   => 'meals#show'
    patch '/meals/:id' => 'meals#update'
    get '/bills'       => 'bills#index'
    get '/residents'   => 'residents#index'
    get '/units'       => 'units#index'
    get '/report'      => 'report#show'
  end

  resources :residents, except: [:create, :update]
  post  '/residents/new'      => 'residents#create'
  patch '/residents/:id/edit' => 'residents#update'

  resources :bills, except: [:create, :update]
  post  '/bills/new'      => 'bills#create'
  patch '/bills/:id/edit' => 'bills#update'

  resources :units, except: [:create, :update]
  post  '/units/new'      => 'units#create'
  patch '/units/:id/edit' => 'units#udpate'

  resources :meals, except: [:create, :update]
  post  '/meals/new'      => 'meals#create'
  patch '/meals/:id/edit' => 'meals#update'

  resources :communities, except: [:create, :update]
  post  '/communities/new'      => 'communities#create'
  patch '/communities/:id/edit' => 'communities#update'

  resources :reconciliations, only: [:create]
end
