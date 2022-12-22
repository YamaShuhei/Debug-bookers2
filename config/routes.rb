Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  get "users/:id/follow" => "users#follow", as: "follow"
  get "users/:id/follower" => "users#follower", as: "follower"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update,:follow,:follower] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end