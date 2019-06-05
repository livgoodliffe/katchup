Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :favourites, only: [:index, :destroy]
  resources :wishlists, only: [:index, :destroy]

  resources :reviews, only: [:index, :show, :create, :update, :edit, :destroy]

  resources :spots, only: [:show, :index] do

    resources :reviews, only: [:create]

    resources :wishlists, only: :create
    resources :favourites, only: :create

  end

  resources :feeds, only: [:index]

  resources :lists, only: [:index]

  resources :discover, only: [:index]

  resources :catchups, only: [:index]

  resources :users, only: [:index] do
    member do
      post :follow
      post :unfollow
    end
 end

  resources :friend_requests, only: [:index, :create, :destroy]

end
