class WeatherService
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def weather_details(location)
    get_url("/v1/forecast.json?q=#{location.lat} #{location.lng}&days=5")
  end

  def weather_details_later(lat, lng, days)
    if days > 0
      get_url("/v1/forecast.json?q=#{lat} #{lng}&days=#{days}")
    else
      get_url("/v1/forecast.json?q=#{lat} #{lng}")
    end
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
     faraday.params['key'] = Rails.application.credentials.maps[:weather_key]
    end
  end
end