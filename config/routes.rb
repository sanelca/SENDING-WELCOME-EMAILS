Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'flights#index', as: 'flights'
  get 'flights/index'
  resources :bookings, only: [:new, :create, :index, :show]
end
