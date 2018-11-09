Rails.application.routes.draw do
  post 'rentals/check-out', to:'rentals#create', as: 'check-out'

  post 'rentals/check-in', to: 'rentals#update', as: 'check-in'

  get 'rentals/overdue', to: 'rentals#overdue', as: 'overdue'

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]
end
