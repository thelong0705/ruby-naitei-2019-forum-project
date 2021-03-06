Rails.application.routes.draw do
  root "static_pages#home"
  
  get "/signup", to: "users#new"
  resources :users, only: %w(show new create)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
