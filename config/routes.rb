Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users

  root 'purchases#index'

  get 'inventory/index'
  get 'permissions/index'

  namespace :api, defaults: {format: 'json'} do
    resources :orders,      only: [:create]
    resources :items,       only: [:index, :create, :show, :update]
    resources :users,       only: [:index, :show, :update] do
      resources :user_abilities,    only: [:create]
    end
    resources :user_abilities,      only: [:destroy]
  end

  match "*path", to: "errors#catch_404", via: :all
end
