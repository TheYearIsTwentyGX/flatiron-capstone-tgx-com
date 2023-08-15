scope "/users", module: "master_security" do
  resources :access_profiles
  resources :requests, controller: "user_requests" do
    collection do
      resources :user_request_positions, path: "positions"
    end
  end
  resources :users, controller: "users", path: "" do
    collection do
      get "/corporate", action: "corporate"
      get "/:id/facilities", action: "facilities"
      patch "/:id/facilities", action: "update_facilities"
      get "/:id/facilities/:type", action: "facilities"
      get "/:id/access_profile", action: "access_profile"
      get "/:id/contact", action: "contact"
      get "/:id/menu_options", to: "menu_options#show"
    end
  end
end
