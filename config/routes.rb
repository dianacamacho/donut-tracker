Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'donuts#index'
  resources :donuts
  resources :vendors, only: [:index]
  get 'hello_world', to: 'hello_world#index'
end
