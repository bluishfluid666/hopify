# frozen_string_literal: true

Rails.application.routes.draw do
  get 'shops/new'
  get '/help', to: 'static_pages#help'
  get '/blog', to: 'static_pages#blog'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/build_shop', to: 'shops#new'
  get '/add_product', to: 'products#new'
  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  get '/shops/:id/mng_orders', to: 'shops#manage', as: :mng_orders
  get 'search', to: 'application#search'
  # post 'products/:id/add_to_cart', to: "products#get_product", as: :add_to_cart
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users
  resources :sessions, only: [:new]
  resources :shops
  resources :products do
    member do
      put :change_price
    end
  end
  resources :product_images, only: %i[show edit update destroy]
  resources :cart_items, only: %i[index create update destroy]
  resources :orders, only: %i[index create destroy]
  resources :order_notices, only: [:edit]
  resources :categories, only: %i[index show]
  # resources :shops, only: [:create, :edit, :update :destroy]
  # Defines the root path route ("/")
  root 'static_pages#home'
end
