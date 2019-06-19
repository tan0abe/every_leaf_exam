Rails.application.routes.draw do
  # namespace :admin do
  #   get 'users/index'
  #   get 'users/new'
  #   get 'users/show'
  #   get 'users/edit'
  # end
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :show, :create]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end
end
