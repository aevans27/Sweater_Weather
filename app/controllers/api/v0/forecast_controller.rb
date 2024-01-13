class Api::V0::ForecastController < ApplicationController
  def index
    if params[:location]
      facade = ForecastFacade.new
      location_coords = facade.location_details(params[:location])
      weather_results = facade.weather_details(location_coords)
      render json: ForecastSerializer.new(weather_results), status: 200
    else
      render json: {errors: "Requires a proper location"}, status: 404
    end
  end
end