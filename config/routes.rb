Rails.application.routes.draw do
  get "home/index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"  # Keep this line for home#index

  # Remove the duplicate root line
  # root "posts#index"

  resources :posts do
    resources :comments
    resources :upvotes, only: :create, controller: "posts/upvotes"
  end
  resources :users
  resources :sessions, only: [ :new, :create, :destroy ]

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  delete "logout", to: "sessions#destroy", as: "logout"
end
