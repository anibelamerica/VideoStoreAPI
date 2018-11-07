Rails.application.routes.draw do
  get 'rentals/create'
  get 'rentals/update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zomg', to: 'application#test', as: 'test'

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]
  
end
