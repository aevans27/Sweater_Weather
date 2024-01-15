class RoadTripFacade
  def trip_details(start, finish)
    service = RoadTripService.new
    Trip.new(service.trip_details(start, finish), start, finish)
  end

  def weather_details_later(lat, lng, days, hours)
    service = WeatherService.new
    TripWeather.new(service.weather_details_later(lat, lng, days), days, hours)
  end
end