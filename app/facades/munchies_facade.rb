class MunchiesFacade
  def munchies_details(destination, food)
    service = MunchiesService.new
    Munchies.new(service.munchies_details(destination, food))
  end

  def weather_details_sep(lat, lng)
    service = WeatherService.new
    Weather.new(service.weather_details_sep(lat, lng))
  end
end