Rails.application.routes.draw do
  post 'rentals/check-out', to:'rentals#create', as: 'check-out'

  post 'rentals/check-in', to: 'rentals#update', as: 'check-in'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zomg', to: 'application#test', as: 'test'

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]



end
