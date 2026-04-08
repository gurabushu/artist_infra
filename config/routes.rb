Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show, :create, :new]

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end