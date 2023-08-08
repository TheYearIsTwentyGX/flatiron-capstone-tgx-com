Rails.application.routes.draw do
  resources :facilities
  resources :facility_accesses
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
