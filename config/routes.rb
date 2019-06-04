Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  get 'users/new'
  get 'users/show'
  resources :tasks
end
