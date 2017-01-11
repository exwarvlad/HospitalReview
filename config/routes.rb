Rails.application.routes.draw do
  devise_for :users

  root "hospitals#index"

  resources :hospitals
  resources :personnels
end
