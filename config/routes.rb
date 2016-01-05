Rails.application.routes.draw do
  resources :funding_sources, only: [:create, :index]
  resources :payments, only: [:create]
end
