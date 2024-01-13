class ForecastFacade
  def location_details(location)
    service = LocationService.new
    Location.new(service.location_details(location))
  end

  # def route_details(start, finish)
  #   service = DirectionService.new
  #   Direction.new(service.route_details(start, finish))
  # end
end