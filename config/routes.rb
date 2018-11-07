Rails.application.routes.draw do
  post 'rentals/check-out', to:'rentals#create', as: 'check-out'

  post 'rentals/check-in', to: 'rentals#update', as: 'check-in'

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]
end
