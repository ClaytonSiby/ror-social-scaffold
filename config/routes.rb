Rails.application.routes.draw do

  # get 'friendships'
  get 'friendships/create'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :friendships, only: [:create] do
    collection do
      get 'accept_friendship'
      get 'decline_friendship'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
