class Api::V1::MunchiesController < ApplicationController
  def index
    if params[:destination] && params[:food]
      facade = MunchiesFacade.new
      munchies_result = facade.munchies_details(params[:destination], params[:food])
      weather_results = facade.weather_details_sep(munchies_result.lat, munchies_result.lng)
require 'pry';binding.pry
      # render json: MunchiesSerializer.new(munchies_result, location_results), status: 200
    else
      render json: {errors: "Requires a proper location"}, status: 404
    end
  end
end