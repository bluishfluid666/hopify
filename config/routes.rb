Rails.application.routes.draw do
  get 'shops/new'
  get '/help', to: "static_pages#help"
  get '/blog', to: "static_pages#blog"
  get '/contact', to: "static_pages#contact"
  get '/signup', to: "users#new"
  get '/login', to: 'sessions#new'
  get '/build_shop', to: "shops#new"
  get '/add_product', to: "products#new"
  get '/products/:id/edit', to: "products#edit", as: :edit_product
  
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users
  resources :sessions, only: [:new]
  resources :shops
  resources :products
  resources :product_images, only: [:show, :edit, :update, :destroy]
  # resources :shops, only: [:create, :edit, :update :destroy]
  # Defines the root path route ("/")
  root "static_pages#home"
end
