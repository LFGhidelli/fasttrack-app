Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stocks
  resources :acquisitions, only: [:new, :create, :update]
  resources :followed_stocks, except: [:update, :edit]
  get "dashboard", to: "pages#dashboard"
  get "portfolio", to: "pages#portfolio"
  get "articles", to: "articles#index"
  get "articles/:id", to: "articles#show"
end
