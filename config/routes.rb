Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
    end
    namespace :v1 do
      resources :munchies, only: [:index]
    end
  end
end
