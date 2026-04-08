Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  resources :users, only: [:index, :show, :create, :new]

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "back_to_home", to: "sessions#back_to_home"
end