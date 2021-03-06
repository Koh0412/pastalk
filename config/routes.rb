Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
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
      get :tag_search
      get :receive_talk
      get :user_talk
    end
    member do
      resources :messages, only: [:index, :create, :destroy]
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :groups do
    collection do
      get :search
    end
    
    member do
      get :connect
      get :details
      resources :groupmessages, only: [:create, :destroy]
    end
  end
  
  resources :connects, only: [:create, :destroy]
  
end
