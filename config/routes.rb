Rails.application.routes.draw do


  devise_for :users
  root 'purchases#index'

  get 'inventory/index'

  namespace :api, defaults: {format: 'json'} do
    resources :orders,      only: [:create]
  end

  match "*path", to: "errors#catch_404", via: :all
end
