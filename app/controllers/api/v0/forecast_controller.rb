class Api::V0::ForecastController < ApplicationController
  def index
    if params[:location]
      facade = ForecastFacade.new
      location_coords = facade.location_details(params[:location])
    else
      render json: {errors: "The weather could not be found"}, status: 404
    end
  end
end