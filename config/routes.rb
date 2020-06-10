Rails.application.routes.draw do
  get 'register', to: 'box#register'
  get '/box/activate', to: 'box#activate'
  post '/box/submit', to: 'box#submit'
  get 'message/new'
  post 'message/create'
  get 'message/read'
  devise_for :users
  root 'message#new'
end
