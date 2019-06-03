Rails.application.routes.draw do
  get 'favourites/index'
  get 'favourites/create'
  get 'favourites/update'
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/create'
  get 'reviews/update'
  get 'reviews/edit'
  get 'reviews/destroy'
  devise_for :users
  root to: 'pages#home'

  resources :spots, only: [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds, only: [:index]
end
