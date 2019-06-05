Rails.application.routes.draw do
  get '/', to: 'tasks#index'

  resources :tasks
  resources :users, only: [:new, :show, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
