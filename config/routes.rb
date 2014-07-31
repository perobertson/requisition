Rails.application.routes.draw do

  root 'purchases#index'

  namespace :api, defaults: {format: 'json'} do
    resources :orders,      only: [:create]
  end

  match "*path", to: "errors#catch_404", via: :all
end
