Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, skip: :all
  
  get :login, to: 'users#login', as: :login
  post :login , to: 'users#user_login'
  get :register , to: 'users#register', as: :register
  post :register, to: 'users#user_register'
  get :logout, to: 'users#logout', as: :logout
  get :dashboard, to: 'dashboard#index', as: :dashboard
  resources :appointments, only: [:index, :show, :new, :create]
  get 'directory', to: 'dashboard#directory', as: :directory
  root "dashboard#directory"

end
