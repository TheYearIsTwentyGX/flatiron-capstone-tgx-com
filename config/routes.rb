# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
	post '/login', to: 'sessions#create'
	resources :facilities, controller: "master_security/facilities"
	resources :access_profiles
	resources :users, controller: "master_security/users" do 
	collection do
		get "/:id/facilities", to: "master_security/users#facilities"
		end
	end
end
