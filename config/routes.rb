Rails.application.routes.draw do
  resources :transcodes
  get 'pages/dev'
  get 'pages/overview'

  resources :metadata
  resources :settings
  resources :workflows
  resources :media
  resources :transcodes

  mount Resque::Server.new, :at => "/resque"

  root to: 'pages#dev'

end
