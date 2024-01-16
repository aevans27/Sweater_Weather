Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      resources :backgrounds, only: [:index]
      post "/users" => "users#create"
      post "/sessions" => "sessions#login"
      post "/road_trip" => "road_trip#trip"
    end
  end
end
