Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root 'employees#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users
  # get 'employees/:page', action: :index, on: :collection
  
end
