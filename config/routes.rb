Rails.application.routes.draw do
  devise_for :users
  get '/admin', to: redirect('/admin/dashboard')

  root "home#index"
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  get 'orders', to: 'orders#index', as: :customer_orders

  # Public pages
  get 'about',   to: 'pages#about',   as: :about
  get 'contact', to: 'pages#contact', as: :contact

  # Cart (session-based)
  resource :cart, only: [:show] do
    post :add_item
    patch :update_item
    delete :remove_item
  end

  # Checkout
  resource :checkout, only: [:show, :create]

  namespace :admin do
    get "dashboard", to: "home#index"
    resources :products
    resources :categories
    resources :orders
    resources :pages, only: [:index, :edit, :update]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end