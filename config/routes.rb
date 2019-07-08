Rails.application.routes.draw do
  # get 'relationships/create'
  # get 'relationships/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
#   get 'homes/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#index'
  
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection do
      resources :tags, only: [:new, :create, :edit, :update, :destroy,]
      get :search
    end
    member do
      get :followings
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :groups do
    collection do
      get :search
    end
  end
end
