Rails.application.routes.draw do

  devise_for :users

  mount ActionCable.server => '/cable'

  root to: 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :spots, only: [ :index, :show ]
      resources :reviews
      resources :users
    end
  end

  resources :favourites, only: [:index, :destroy]

  resources :wishlists, only: [:index, :destroy]

  resources :reviews, only: [:index, :show, :create, :update, :edit, :destroy]

  resources :spots, only: [:show, :index] do
    resources :reviews, only: [:create]
    resources :wishlists, only: :create
    resources :favourites, only: :create
  end

  resources :feeds, only: [:index]

  resources :maps, only: [:index]

  resources :lists, only: [:index]

  resources :discover, only: [:index]

  resources :catchups, only: [:index, :new, :create]

  resources :search, only: [:index]

  resources :users, only: [:index]

  resources :users, only: [:index, :show] do
    member do
      post :follow
      post :unfollow
      get :wishlists, only: [:index]
      get :favourites, only: [:index]
      get :friendships, only: [:index]
    end
  end

  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships, only: [:index]


  resources :pending, only: [:index, :destroy]
  resources :request, only: [:index, :destroy]

  resources :geolocation, only: [:index]

end
