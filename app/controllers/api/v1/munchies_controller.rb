class Api::V1::MunchiesController < ApplicationController
  def index
    if params[:destination] && params[:food]
      facade = MunchiesFacade.new
      munchies_result = facade.munchies_details(params[:destination], params[:food])
      weather_results = facade.weather_details_sep(munchies_result.lat, munchies_result.lng)
      munchies_result.forecast[:summary] = weather_results.current_weather[:condition]
      munchies_result.forecast[:temperature] = weather_results.current_weather[:temperature]
      render json: MunchiesSerializer.new(munchies_result), status: 200
    else
      render json: {errors: "Requires a proper location"}, status: 404
    end
  end
end