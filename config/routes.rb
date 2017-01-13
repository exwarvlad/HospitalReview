Rails.application.routes.draw do
  devise_for :users

  root "hospitals#index"

  resources :hospitals do
    resources :hospital_personnels
  end
  resources :personnels
  resources :hospital_personnels

end
