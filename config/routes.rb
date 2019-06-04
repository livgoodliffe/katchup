Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :favourites, only: [:index, :create, :update]

  resources :wishlists, only: [:index, :create, :update]

  resources :reviews, only: [:index, :show, :create, :update, :edit, :destroy]

  resources :spots, only: [:show, :index] do
    resources :reviews, only: [:create]
  end

  resources :feeds, only: [:index]

  resources :lists, only: [:index]

  resources :discover, only: [:index]

  resources :catchups, only: [:index]
end
