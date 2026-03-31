Rails.application.routes.draw do
  # Devise (Authentication)
  devise_for :users

  # -----------------
  # Public (Customer-facing)
  # -----------------
  root "home#index"

  resources :products, only: [:index, :show] do
    collection do
      get :search   # optional if you later want separate search action
    end
  end

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