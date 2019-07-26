Rails.application.routes.draw do
  root "static_pages#home"
  
  get "/signup", to: "users#new"
  resources :users, only: %i(show new create)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :sub_forums, except: :edit
  resources :members, only: %i(create destroy)
  resources :password_resets, only: %i(new create edit update)
  resources :members, only: %i(create destroy)
  get "/submit", to: "posts#new"
  post "/submit", to: "posts#create"
  resources :posts, only: %i(show update)
  get "/search", to: "searchs#new"
end
