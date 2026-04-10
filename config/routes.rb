Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  resources :users, only: [:index, :show, :create, :new] do
    resource :favorite, only: [:create, :destroy]
    resource :creator_subscription, only: [:create], controller: "creator_subscriptions"

    member do
      get :chat, to: "chats#show"
      post :chat, to: "chats#create"
    end

    collection do
      get :matches
    end
  end

  resource :mypage, only: [:show, :update], controller: "profiles" do
    delete :avatar_image, to: "profiles#destroy_avatar_image"
  end

  resource :billing_subscription, only: [:create, :destroy]
  resource :subscription_plan, only: [:create, :update]

  resources :contracts, only: [] do
    resources :reviews, only: [:new, :create]
  end

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "back_to_home", to: "sessions#back_to_home"
end