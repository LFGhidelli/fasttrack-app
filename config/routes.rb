Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stocks do
    resources :acquistions, only: [:new, :create, :update]
  end
  resources :followed_stocks
  get "dashboard", to: "pages#dashboard"
  get "portfolio", to: "pages#portfolio"
end
