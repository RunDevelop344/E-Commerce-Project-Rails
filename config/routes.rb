Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users

  # -----------------
  # Public user pages
  # -----------------
  namespace :users do
    root "home#index"          # Users visit /users → homepage
    get "/", to: "home#index"  # optional, same as above
    resources :products, only: [:index, :show]  # users can browse products
  end

  # Public homepage
  root "users/home#index"      # "/" points to users' homepage

  # -----------------
  # Admin pages
  # -----------------
  namespace :admin do
    get "dashboard", to: "home#index"
    resources :products
    resources :orders
  end

  # -----------------
  # Health check
  # -----------------
  get "up" => "rails/health#show", as: :rails_health_check
end