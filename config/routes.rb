Rails.application.routes.draw do
  # Devise (Authentication)
  devise_for :users

  # Add this line - redirects /admin to /admin/dashboard
  get '/admin', to: redirect('/admin/dashboard')

  # -----------------
  # Public (Customer-facing)
  # -----------------
  root "home#index"

  resources :products, only: [:index, :show]

  resources :categories, only: [:index, :show]

  # -----------------
  # Admin (Back-office)
  # -----------------
  namespace :admin do
    get "dashboard", to: "home#index"
    resources :products
    resources :categories
    resources :orders
  end

  # -----------------
  # Health check
  # -----------------
  get "up" => "rails/health#show", as: :rails_health_check
end