Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'user_vendors#index'
  
  resources :donuts
  resources :vendors, except: [:show], path: 'shops'
  resources :user_vendors, only: [:create, :destroy]

  get '/my-shops', to: 'user_vendors#index', as: :my_shops
  get 'hello_world', to: 'hello_world#index'
end
