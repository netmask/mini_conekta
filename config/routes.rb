Rails.application.routes.draw do
  root 'tpv#index'

  resources :funding_sources, only: [:create, :index]
  resources :payments, only: [:create]
end
