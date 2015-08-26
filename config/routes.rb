Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    # omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  root 'purchases#index'

  get 'purchases/history'
  get 'inventory/index'
  get 'permissions/index'
  resources :categories

  namespace :api, defaults: { format: 'json' } do
    resources :orders,      only: [:create]
    resources :items,       only: [:index, :create, :show, :update]
    resources :users,       only: [:index, :show, :update] do
      resources :user_abilities,    only: [:create]
      resources :orders,            only: [:index]
    end
    resources :user_abilities,      only: [:destroy]
  end

  match '*path', to: 'errors#catch_404', via: :all
end
