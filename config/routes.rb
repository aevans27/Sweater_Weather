Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      post "/users" => "users#create"
      post "/sessions" => "sessions#login"
      post "/road_trip" => "road_trip#trip"
      #  get "/markets/search", to: "markets_lookup#show"
      #  delete "/market_vendors", to: "market_vendors#destroy"
      # # get "/items/find_all", to: "items_lookup#index"
      # # get "/items/find", to: "items_lookup#show"
      # resources :markets, only: [:index, :show] do
      #   resources :vendors, only: [:index]
      #   resources :nearest_atms, only: [:index]
      # end

      # resources :vendors, only: [:index, :show, :create, :destroy, :update] do
      #   # resources :merchant, only: [:index], controller: "item_merchants"
      # end

      # resources :market_vendors, only: [:create] do
      #   # resources :merchant, only: [:index], controller: "item_merchants"
      # end
    end
  end
end
