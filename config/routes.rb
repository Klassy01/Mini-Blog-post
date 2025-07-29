Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Root route
  root 'posts#index'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Posts routes
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # API routes
  namespace :api do
    resources :posts, only: [:index, :show]
  end

  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
