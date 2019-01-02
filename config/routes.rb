Rails.application.routes.draw do
  resources :memberships, only: [:create, :destroy]
  resources :bands
  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:show, :new, :create, :edit, :update, :destroy, :index] do
    resources :posts, only: [:index, :new, :create]
  end
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  root "application#welcome", as: "home"
  get "/sessions", to: "sessions#new"
end
