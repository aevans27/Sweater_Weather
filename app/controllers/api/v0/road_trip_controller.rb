class Api::V0::RoadTripController < ApplicationController
  def trip
    existing_user = User.find_by(api_key: params[:api_key])
    if existing_user && params[:origin].present? && params[:destination].present?
      facade = RoadTripFacade.new
      trip_results = facade.trip_details(params[:origin], params[:destination])
      if trip_results.travel_time == "impossible route"
        trip_results.weather_at_eta[:datetime] = ""
        trip_results.weather_at_eta[:temperature] = ""
        trip_results.weather_at_eta[:condition] = ""
        render json: RoadTripSerializer.new(trip_results), status: 200
      else
        current_time = Time.new
        start_time = current_time.to_s.split[1]
        start_time_hours = start_time.split(":")
        route_hours = trip_results.travel_time.split(":")
        total_hours = route_hours.first.to_i + start_time_hours.first.to_i
        if total_hours >= 24
          days_to_complete = total_hours/24.to_i
          remaining_hours = total_hours % 24
        else
          days_to_complete = 0
          remaining_hours = total_hours
        end
        weather_results = facade.weather_details_later(trip_results.lat, trip_results.lng, days_to_complete, remaining_hours)
        end_trip_weather = weather_results.hourly_weather[remaining_hours]
        trip_results.weather_at_eta[:datetime] = end_trip_weather[:time]
        trip_results.weather_at_eta[:temperature] = end_trip_weather[:temperature]
        trip_results.weather_at_eta[:condition] = end_trip_weather[:conditions]
        
        render json: RoadTripSerializer.new(trip_results), status: 200
      end
    else
      render json: {errors: "Bad Credentials"}, status: 401
    end
  end
end