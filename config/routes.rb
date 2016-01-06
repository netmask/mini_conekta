Rails.application.routes.draw do
  root 'tpv#index'

  resources :funding_sources, only: [:create]
  resources :payments, only: [:create, :index]
end
