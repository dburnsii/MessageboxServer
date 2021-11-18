Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'register', to: 'box#register'
  get '/box/activate', to: 'box#activate'
  post '/box/submit', to: 'box#submit'
  get '/box/update', to: 'box#update'
  get 'message/new'
  post 'message/create'
  get 'message/read'
  get 'firmware/new'
  post 'firmware/new', to: 'firmware#create'
  devise_for :users
  resources :users
  root 'message#new'
end
