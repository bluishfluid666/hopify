Rails.application.routes.draw do
  get '/help', to: "static_pages#help"
  get '/blog', to: "static_pages#blog"
  get '/contact', to: "static_pages#contact"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#home"
end
