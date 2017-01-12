Rails.application.routes.draw do
  devise_for :users

  root "hospitals#index"

  resources :hospitals
  resources :personnels
  resources :hospital_personnels do
    post 'add_personnel', on: :member
  end
end
