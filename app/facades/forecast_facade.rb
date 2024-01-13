class ForecastFacade
  def location_details(location)
    service = LocationService.new
    Location.new(service.location_details(location))
  end

  def weather_details(coords)
    service = WeatherService.new
    Weather.new(service.weather_details(coords))
  end
end