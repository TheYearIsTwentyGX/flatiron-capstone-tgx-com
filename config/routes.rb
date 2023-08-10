# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
	post '/login', to: 'sessions#create'
	get '/users/:id', to: 'master_security/users#show'
	resources :facilities, controller: "master_security/facilities"
end
