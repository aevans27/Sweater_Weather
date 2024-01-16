class Api::V0::BackgroundsController < ApplicationController
  def index
    if params[:location]
      facade = ImageFacade.new
      image_results = facade.image_details(params[:location])
      render json: ImageSerializer.new(image_results), status: 200
    else
      render json: {errors: "Requires a proper location"}, status: 404
    end
  end
end