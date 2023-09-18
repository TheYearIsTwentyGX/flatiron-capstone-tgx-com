# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  resources :facilities, controller: "facilities"
  resources :access_profiles
  resources :users, controller: "users" do
    collection do
      get "/:id/facilities", to: "users#facilities"
    end
  end
  get "/session", to: "sessions#show"
end
