Rails.application.routes.draw do
  root "products#index"
  devise_for :users

  resources :products, only: [:index, :show]
  resource  :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :orders, only: [:index, :show, :create, :update]

  namespace :seller do
    resources :products, except: [:index, :show]
    resources :orders, only: [:index, :show, :update]
  end
end
