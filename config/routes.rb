Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'vendors#index'
  resources :donuts
  resources :vendors, except: [:show]
  resources :user_vendors
  get 'hello_world', to: 'hello_world#index'
end
